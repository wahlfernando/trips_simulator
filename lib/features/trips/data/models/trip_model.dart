class TripModel {
  final String id;
  final String lineName;
  final String departureTime;
  final String status;

  const TripModel({
    required this.id,
    required this.lineName,
    required this.departureTime,
    required this.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as String,
      lineName: json['lineName'] as String,
      departureTime: json['departureTime'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'lineName': lineName,
    'departureTime': departureTime,
    'status': status,
  };
}
