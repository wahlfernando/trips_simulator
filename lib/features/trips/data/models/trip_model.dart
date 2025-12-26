import '../../domain/entities/trip.dart';

class TripModel extends Trip {
  const TripModel({
    required super.id,
    required super.lineName,
    required super.departureTime,
    required super.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String,
      lineName: json['lineName'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      status: _statusFromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'lineName': lineName,
    'departureTime': departureTime.toIso8601String(),
    'status': status.name,
  };

  static TripStatus _statusFromString(String value) {
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
}
