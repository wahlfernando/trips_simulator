import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_detail/trip_detail_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_detail/trip_detail_event.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_detail/trip_detail_state.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_chip.dart';
import '../../../../trip_remote_data_source.dart' as di;

class TripDetailPage extends StatelessWidget {
  final String tripId;

  const TripDetailPage({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TripDetailBloc(getTripDetail: di.getTripDetailUseCase)
            ..add(TripDetailStarted(tripId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Detalhe da Viagem')),
        body: BlocBuilder<TripDetailBloc, TripDetailState>(
          builder: (context, state) {
            if (state.status == TripDetailStatus.loading ||
                state.status == TripDetailStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == TripDetailStatus.failure) {
              return Center(
                child: Text(state.errorMessage ?? 'Erro ao carregar detalhe'),
              );
            }

            final trip = state.trip!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Linha: ${trip.lineName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Horário de saída: ${trip.formattedDepartureDate} às ${trip.formattedDepartureTime}',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Status: '),
                      StatusChip(status: trip.status),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'O status é atualizado automaticamente a cada 5 segundos.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
