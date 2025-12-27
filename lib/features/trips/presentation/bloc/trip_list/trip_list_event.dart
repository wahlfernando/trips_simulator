import '../../../../../core/enums/trip_filter.dart';

abstract class TripListEvent {}

class TripListRequested extends TripListEvent {}

class TripListRefreshed extends TripListEvent {}

class ChangeFilterEvent extends TripListEvent {
  final TripFilter filter;

  ChangeFilterEvent(this.filter);
}
