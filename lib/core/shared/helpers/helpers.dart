import 'package:trips_simulator/core/enums/trip_status.dart';

class Helpers {
  static TripStatus statusFromString(String value) {
    switch (value) {
      case 'scheduled':
        return TripStatus.scheduled;
      case 'in_progress':
        return TripStatus.inProgress;
      case 'finished':
        return TripStatus.finished;
      default:
        return TripStatus.scheduled;
    }
  }

  static String statusToString(TripStatus status) {
    switch (status) {
      case TripStatus.scheduled:
        return 'scheduled';
      case TripStatus.inProgress:
        return 'in_progress';
      case TripStatus.finished:
        return 'finished';
    }
  }

  static String simulateStatusChange(String currentStatus) {
    switch (currentStatus) {
      case 'scheduled':
        return 'in_progress';
      case 'in_progress':
        return 'finished';
      case 'finished':
        return 'finished';
      default:
        return currentStatus;
    }
  }
}
