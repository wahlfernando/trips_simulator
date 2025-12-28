import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/card_trips.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/filter_chips_button.dart';
import '../bloc/trip_list/trip_list_bloc.dart';
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
            TripFilterChips(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: currentState.trips.length,
                separatorBuilder: (_, _) => const SizedBox.shrink(),
                itemBuilder: (context, index) {
                  return TripCard(trip: currentState.trips[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
