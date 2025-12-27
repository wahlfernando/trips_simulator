import 'dart:async';
import 'package:trips_simulator/core/shared/helpers/helpers.dart';

import '../models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<List<TripModel>> getTrips();
  Future<TripModel> getTripDetail(String id);
}

class TripRemoteDataSourceFake implements TripRemoteDataSource {
  final List<TripModel> _trips = [
    TripModel(
      id: '1',
      lineName: 'Linha A - Centro',
      departureTime: DateTime.now()
          .add(const Duration(minutes: 10))
          .toIso8601String(),
      status: 'scheduled',
    ),
    TripModel(
      id: '2',
      lineName: 'Linha B - Aeroporto',
      departureTime: DateTime.now()
          .subtract(const Duration(minutes: 5))
          .toIso8601String(),
      status: 'in_progress',
    ),
    TripModel(
      id: '3',
      lineName: 'Linha C - Bairro',
      departureTime: DateTime.now()
          .subtract(const Duration(minutes: 40))
          .toIso8601String(),
      status: 'finished',
    ),
  ];

  @override
  Future<List<TripModel>> getTrips() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _trips;
  }

  @override
  Future<TripModel> getTripDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final trip = _trips.firstWhere((t) => t.id == id);

    final updatedStatus = Helpers.simulateStatusChange(trip.status);

    final updatedTrip = TripModel(
      id: trip.id,
      lineName: trip.lineName,
      departureTime: trip.departureTime,
      status: updatedStatus,
    );

    final index = _trips.indexWhere((t) => t.id == id);
    _trips[index] = updatedTrip;

    return updatedTrip;
  }
}
