import 'package:flutter/material.dart';
import '../../../../core/enums/trip_status.dart';

class StatusChip extends StatelessWidget {
  final TripStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case TripStatus.scheduled:
        color = const Color(0xFF2196F3);
        label = 'Scheduled';
        break;
      case TripStatus.inProgress:
        color = const Color(0xFFFF9800);
        label = 'In progress';
        break;
      case TripStatus.finished:
        color = const Color(0xFF4CAF50);
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
