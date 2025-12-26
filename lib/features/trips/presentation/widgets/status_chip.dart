import 'package:flutter/material.dart';
import 'package:trips_simulator/features/trips/domain/entities/trip.dart';

class StatusChip extends StatelessWidget {
  final TripStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case TripStatus.scheduled:
        color = Colors.blue;
        label = 'Scheduled';
        break;
      case TripStatus.inProgress:
        color = Colors.orange;
        label = 'In progress';
        break;
      case TripStatus.finished:
        color = Colors.green;
        label = 'Finished';
        break;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.15),
      labelStyle: TextStyle(color: color),
    );
  }
}
