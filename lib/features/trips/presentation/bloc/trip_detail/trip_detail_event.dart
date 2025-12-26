import 'package:equatable/equatable.dart';

abstract class TripDetailEvent extends Equatable {
  const TripDetailEvent();

  @override
  List<Object?> get props => [];
}

class TripDetailStarted extends TripDetailEvent {
  final String tripId;

  const TripDetailStarted(this.tripId);

  @override
  List<Object?> get props => [tripId];
}

class TripDetailTicked extends TripDetailEvent {
  final String tripId;

  const TripDetailTicked(this.tripId);

  @override
  List<Object?> get props => [tripId];
}
