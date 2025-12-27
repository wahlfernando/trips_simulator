import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/trip_list_status.dart';
import '../../../../../core/enums/trip_filter.dart';
import '../../../../../core/enums/trip_status.dart';
import '../../../domain/entities/trip.dart';
import 'trip_list_event.dart';
import 'trip_list_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/get_trips.dart';

class TripListBloc extends Bloc<TripListEvent, TripListState> {
  final GetTrips getTrips;

  TripListBloc({required this.getTrips}) : super(const TripListState()) {
    on<TripListRequested>(_onRequested);
    on<TripListRefreshed>(_onRequested);
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  Future<void> _onRequested(
    TripListEvent event,
    Emitter<TripListState> emit,
  ) async {
    emit(state.copyWith(status: TripListStatus.loading));

    final result = await getTrips(const NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TripListStatus.failure,
          errorMessage: failure.message,
          trips: const [],
          allTrips: const [],
        ),
      ),
      (trips) {
        if (trips.isEmpty) {
          emit(
            state.copyWith(
              status: TripListStatus.empty,
              trips: const [],
              allTrips: const [],
            ),
          );
        } else {
          final filtered = _applyFilter(trips, state.selectedFilter);
          emit(
            state.copyWith(
              status: TripListStatus.success,
              allTrips: trips,
              trips: filtered,
            ),
          );
        }
      },
    );
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<TripListState> emit) {
    final filtered = _applyFilter(state.allTrips, event.filter);
    emit(state.copyWith(selectedFilter: event.filter, trips: filtered));
  }

  List<Trip> _applyFilter(List<Trip> trips, TripFilter filter) {
    switch (filter) {
      case TripFilter.todas:
        return trips;
      case TripFilter.agendadas:
        return trips.where((t) => t.status == TripStatus.scheduled).toList();
      case TripFilter.emAndamento:
        return trips.where((t) => t.status == TripStatus.inProgress).toList();
      case TripFilter.finalizadas:
        return trips.where((t) => t.status == TripStatus.finished).toList();
    }
  }
}
