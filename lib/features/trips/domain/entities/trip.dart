import '../../../../core/enums/trip_status.dart';

class Trip {
  final String id;
  final String lineName;
  final DateTime departureTime;
  final TripStatus status;

  const Trip({
    required this.id,
    required this.lineName,
    required this.departureTime,
    required this.status,
  });

  Trip copyWith({
    String? id,
    String? lineName,
    DateTime? departureTime,
    TripStatus? status,
  }) {
    return Trip(
      id: id ?? this.id,
      lineName: lineName ?? this.lineName,
      departureTime: departureTime ?? this.departureTime,
      status: status ?? this.status,
    );
  }

  String get formattedDepartureDate {
    final day = departureTime.day.toString().padLeft(2, '0');
    final month = departureTime.month.toString().padLeft(2, '0');
    final year = departureTime.year.toString();
    return '$day/$month/$year';
  }

  String get formattedDepartureTime {
    final hour = departureTime.hour.toString().padLeft(2, '0');
    final minute = departureTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
