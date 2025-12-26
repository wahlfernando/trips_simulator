import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trips_simulator/core/routes/app_routes.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_event.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_state.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/status_chip.dart';
import '../../../../core/enums/trip_list_status.dart';
import '../../../../trip_remote_data_source.dart' as di;

class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TripListBloc(getTrips: di.getTripsUseCase)..add(TripListRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Viagens Corporativas')),
        body: BlocBuilder<TripListBloc, TripListState>(
          builder: (context, state) {
            switch (state.status) {
              case TripListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case TripListStatus.failure:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.errorMessage ?? 'Erro ao carregar'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => context.read<TripListBloc>().add(
                          TripListRequested(),
                        ),
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                );
              case TripListStatus.empty:
                return const Center(child: Text('Nenhuma viagem encontrada'));
              case TripListStatus.success:
                return ListView.separated(
                  itemCount: state.trips.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final trip = state.trips[index];
                    return ListTile(
                      title: Text(trip.lineName),
                      subtitle: Text(
                        'Saída: ${trip.departureTime}',
                        maxLines: 1,
                      ),
                      trailing: StatusChip(status: trip.status),
                      onTap: () {
                        context.push('${AppRoutes.tripDetail}/${trip.id}');
                      },
                    );
                  },
                );
              case TripListStatus.initial:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
