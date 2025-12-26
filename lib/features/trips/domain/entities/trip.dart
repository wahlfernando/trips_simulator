enum TripStatus { scheduled, inProgress, finished }

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
}
