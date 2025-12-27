import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_event.dart';

import '../bloc/trip_list/trip_list_state.dart';

class FailurePage extends StatefulWidget {
  final TripListState state;

  const FailurePage({super.key, required this.state});

  @override
  State<FailurePage> createState() => _FailurePageState();
}

class _FailurePageState extends State<FailurePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.state.errorMessage ?? 'Erro ao carregar'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () =>
                context.read<TripListBloc>().add(TripListRequested()),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
