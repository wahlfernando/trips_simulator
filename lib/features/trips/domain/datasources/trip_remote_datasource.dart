import 'package:trips_simulator/features/trips/data/models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<List<TripModel>> getTrips();
  Future<TripModel> getTripDetail(String id);
}
