import 'package:flutter/material.dart';
import 'package:trips_simulator/core/shared/theme/app_text_style.dart';
import 'package:trips_simulator/core/shared/theme/color_style.dart';
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
        color = AppColors.primario;
        label = 'Agendado';
        break;
      case TripStatus.inProgress:
        color = const Color(0xFFFF9800);
        label = 'Em Andamento';
        break;
      case TripStatus.finished:
        color = const Color(0xFF4CAF50);
        label = 'Finalizado';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
        child: Text(
          label,
          style: AppTextStyle.text.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
