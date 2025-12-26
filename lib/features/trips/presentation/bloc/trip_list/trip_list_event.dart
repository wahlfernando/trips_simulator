import 'package:equatable/equatable.dart';

abstract class TripListEvent extends Equatable {
  const TripListEvent();

  @override
  List<Object?> get props => [];
}

class TripListRequested extends TripListEvent {}

class TripListRefreshed extends TripListEvent {}
