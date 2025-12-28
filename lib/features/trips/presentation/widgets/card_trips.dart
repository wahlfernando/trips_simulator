import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'status_chip.dart';
import '../../domain/entities/trip.dart';
import '../../../../core/shared/routes/app_routes.dart';
import '../../../../core/shared/theme/app_text_style.dart';
import '../../../../core/shared/theme/color_style.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black50),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            context.push('${AppRoutes.tripDetail}/${trip.id}');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: .center,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Row(
                      crossAxisAlignment: .end,
                      spacing: 8,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.black50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.car_repair, color: AppColors.white),
                        ),
                        Text(trip.lineName, style: AppTextStyle.textTripCard),
                      ],
                    ),
                    Row(
                      spacing: 6,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: AppColors.black50,
                        ),
                        Text(trip.formattedDepartureDate),
                        const SizedBox(width: 8),
                        Icon(Icons.access_time, color: AppColors.black50),
                        Text(trip.formattedDepartureTime),
                      ],
                    ),
                    StatusChip(status: trip.status),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.black50,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
