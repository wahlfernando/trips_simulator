import 'package:equatable/equatable.dart';
import '../../../domain/entities/trip.dart';

enum TripListStatus { initial, loading, success, empty, failure }

class TripListState extends Equatable {
  final TripListStatus status;
  final List<Trip> trips;
  final String? errorMessage;

  const TripListState({
    this.status = TripListStatus.initial,
    this.trips = const [],
    this.errorMessage,
  });

  TripListState copyWith({
    TripListStatus? status,
    List<Trip>? trips,
    String? errorMessage,
  }) {
    return TripListState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, trips, errorMessage];
}
