import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trips_simulator/core/shared/routes/app_routes.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_chip.dart';

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
    return ListView.separated(
      itemCount: widget.state.trips.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final trip = widget.state.trips[index];
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
      },
    );
  }
}
