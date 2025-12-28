import 'package:flutter/material.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_chip.dart';

import '../../../../core/enums/trip_status.dart';
import '../../../../core/shared/theme/app_text_style.dart';
import '../../../../core/shared/theme/color_style.dart';

class LineTitleInfo extends StatelessWidget {
  final IconData icon;
  final String textTitle;
  final String? textInfo;
  final TripStatus? status;
  final bool? isStatus;

  const LineTitleInfo({
    super.key,
    required this.icon,
    required this.textTitle,
    this.textInfo,
    this.status,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: .center,
          spacing: 8,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.grey),
            ),
            Text(textTitle, style: AppTextStyle.textDetailCard),
          ],
        ),
        !isStatus!
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  textInfo ?? '',
                  style: AppTextStyle.textDetailCard.copyWith(
                    color: AppColors.black80,
                  ),
                ),
              )
            : StatusChip(status: status!),
      ],
    );
  }
}
