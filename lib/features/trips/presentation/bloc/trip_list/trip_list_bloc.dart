import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/trip_list_status.dart';
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
        ),
      ),
      (trips) {
        if (trips.isEmpty) {
          emit(state.copyWith(status: TripListStatus.empty, trips: []));
        } else {
          emit(state.copyWith(status: TripListStatus.success, trips: trips));
        }
      },
    );
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<TripListState> emit) {
    emit(state.copyWith(selectedFilter: event.filter));
  }
}
