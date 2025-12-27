class TripDto {
  final String id;
  final String lineName;
  final String departureTime;
  final String status;

  const TripDto({
    required this.id,
    required this.lineName,
    required this.departureTime,
    required this.status,
  });
}
