import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trips_simulator/core/shared/routes/app_routes.dart';
import 'package:trips_simulator/core/shared/theme/color_style.dart';
import 'package:trips_simulator/features/trips/domain/entities/trip.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_event.dart';
import 'package:trips_simulator/core/components/filter_chip_button.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_chip.dart';

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
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final trip = currentState.trips[index];
                  return cardTrip(trip, context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget cardTrip(Trip trip, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black80),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(trip.lineName),
          subtitle: Text(
            'Saída: ${trip.formattedDepartureDate} às ${trip.formattedDepartureTime}',
            maxLines: 1,
          ),
          trailing: StatusChip(status: trip.status),
          onTap: () {
            context.push('${AppRoutes.tripDetail}/${trip.id}');
          },
        ),
      ),
    );
  }
}
