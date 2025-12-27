import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trips_simulator/core/shared/routes/app_routes.dart';
import 'package:trips_simulator/core/shared/theme/color_style.dart';
import 'package:trips_simulator/features/trips/domain/entities/trip.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_event.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/filter_chip_button.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_card.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_chip.dart';

import '../../../../core/enums/trip_filter.dart';
import '../bloc/trip_list/trip_list_state.dart';

class SuccessPage extends StatefulWidget {
  final TripListState state;

  const SuccessPage({super.key, required this.state});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.7,
              children: const [
                StatCard(
                  label: 'Total',
                  value: 5,
                  indicatorColor: AppColors.black80,
                ),
                StatCard(
                  label: 'Agendadas',
                  value: 3,
                  indicatorColor: AppColors.orange,
                ),
                StatCard(
                  label: 'Em Andamento',
                  value: 1,
                  indicatorColor: AppColors.green,
                ),
                StatCard(
                  label: 'Finalizadas',
                  value: 1,
                  indicatorColor: AppColors.purple100,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChipButton(
                  label: 'Todas',
                  isSelected: widget.state.selectedFilter == TripFilter.todas,
                  onTap: () {
                    context.read<TripListBloc>().add(
                      ChangeFilterEvent(TripFilter.todas),
                    );
                  },
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: 'Agendadas',
                  isSelected:
                      widget.state.selectedFilter == TripFilter.agendadas,
                  onTap: () {
                    context.read<TripListBloc>().add(
                      ChangeFilterEvent(TripFilter.agendadas),
                    );
                  },
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: 'Em Andamento',
                  isSelected:
                      widget.state.selectedFilter == TripFilter.emAndamento,
                  onTap: () {
                    context.read<TripListBloc>().add(
                      ChangeFilterEvent(TripFilter.emAndamento),
                    );
                  },
                ),
                const SizedBox(width: 8),
                FilterChipButton(
                  label: 'Finalizadas',
                  isSelected:
                      widget.state.selectedFilter == TripFilter.finalizadas,
                  onTap: () {
                    context.read<TripListBloc>().add(
                      ChangeFilterEvent(TripFilter.finalizadas),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: widget.state.trips.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final trip = widget.state.trips[index];
              return cardTrip(trip, context);
            },
          ),
        ),
      ],
    );
  }

  ListTile cardTrip(Trip trip, BuildContext context) {
    return ListTile(
      title: Text(trip.lineName),
      subtitle: Text(
        'Saída: ${trip.formattedDepartureDate} às ${trip.formattedDepartureTime}',
        maxLines: 1,
      ),
      trailing: StatusChip(status: trip.status),
      onTap: () {
        context.push('${AppRoutes.tripDetail}/${trip.id}');
      },
    );
  }
}
