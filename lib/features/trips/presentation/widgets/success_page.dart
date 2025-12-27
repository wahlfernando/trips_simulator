import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/theme/app_text_style.dart';
import '../../../../core/shared/theme/color_style.dart';
import '../../domain/entities/trip.dart';
import '../bloc/trip_list/trip_list_bloc.dart';
import '../bloc/trip_list/trip_list_event.dart';
import '../../../../core/components/filter_chip_button.dart';
import '../../../../core/enums/trip_filter.dart';
import '../bloc/trip_list/trip_list_state.dart';

class SuccessPage extends StatelessWidget {
  final TripListState state;

  const SuccessPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripListBloc, TripListState>(
      builder: (context, currentState) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Wrap(
                spacing: 4,
                runSpacing: 8,
                children: [
                  Icon(Icons.filter_list, color: AppColors.black80, size: 30),
                  FilterChipButton(
                    label: 'Todas',
                    isSelected: currentState.selectedFilter == TripFilter.todas,
                    onTap: () {
                      context.read<TripListBloc>().add(
                        ChangeFilterEvent(TripFilter.todas),
                      );
                    },
                  ),
                  FilterChipButton(
                    label: 'Agendadas',
                    isSelected:
                        currentState.selectedFilter == TripFilter.agendadas,
                    onTap: () {
                      context.read<TripListBloc>().add(
                        ChangeFilterEvent(TripFilter.agendadas),
                      );
                    },
                  ),
                  FilterChipButton(
                    label: 'Em Andamento',
                    isSelected:
                        currentState.selectedFilter == TripFilter.emAndamento,
                    onTap: () {
                      context.read<TripListBloc>().add(
                        ChangeFilterEvent(TripFilter.emAndamento),
                      );
                    },
                  ),
                  FilterChipButton(
                    label: 'Finalizadas',
                    isSelected:
                        currentState.selectedFilter == TripFilter.finalizadas,
                    onTap: () {
                      context.read<TripListBloc>().add(
                        ChangeFilterEvent(TripFilter.finalizadas),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: currentState.trips.length,
                separatorBuilder: (_, _) => const SizedBox.shrink(),
                itemBuilder: (context, index) {
                  final trip = currentState.trips[index];
                  return _cardTrip(trip, context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _cardTrip(Trip trip, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black50),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
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
                Row(children: [Icon(Icons.close)]),
              ],
            ),
          ),
        ),

        // ListTile(
        //   title: ,
        //   subtitle: Text(
        //     'Saída: ${trip.formattedDepartureDate} às ${trip.formattedDepartureTime}',
        //     maxLines: 1,
        //   ),
        //   trailing: StatusChip(status: trip.status),
        //   onTap: () {
        //     context.push('${AppRoutes.tripDetail}/${trip.id}');
        //   },
        // ),
      ),
    );
  }
}
