import 'package:equatable/equatable.dart';
import '../../../domain/entities/trip.dart';

enum TripDetailStatus { initial, loading, success, failure }

class TripDetailState extends Equatable {
  final TripDetailStatus status;
  final Trip? trip;
  final String? errorMessage;

  const TripDetailState({
    this.status = TripDetailStatus.initial,
    this.trip,
    this.errorMessage,
  });

  TripDetailState copyWith({
    TripDetailStatus? status,
    Trip? trip,
    String? errorMessage,
  }) {
    return TripDetailState(
      status: status ?? this.status,
      trip: trip ?? this.trip,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, trip, errorMessage];
}
