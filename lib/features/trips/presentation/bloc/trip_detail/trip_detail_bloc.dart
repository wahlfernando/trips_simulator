import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trip_detail_event.dart';
import 'trip_detail_state.dart';
import '../../../domain/usecases/get_trip_detail.dart';

class TripDetailBloc extends Bloc<TripDetailEvent, TripDetailState> {
  final GetTripDetail getTripDetail;

  Timer? _timer;

  TripDetailBloc({required this.getTripDetail})
    : super(const TripDetailState()) {
    on<TripDetailStarted>(_onStarted);
    on<TripDetailTicked>(_onTicked);
  }

  Future<void> _onStarted(
    TripDetailStarted event,
    Emitter<TripDetailState> emit,
  ) async {
    emit(state.copyWith(status: TripDetailStatus.loading));
    await _fetchDetail(event.tripId, emit);

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => add(TripDetailTicked(event.tripId)),
    );
  }

  Future<void> _onTicked(
    TripDetailTicked event,
    Emitter<TripDetailState> emit,
  ) async {
    await _fetchDetail(event.tripId, emit);
  }

  Future<void> _fetchDetail(String id, Emitter<TripDetailState> emit) async {
    final result = await getTripDetail(id);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TripDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (trip) =>
          emit(state.copyWith(status: TripDetailStatus.success, trip: trip)),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
