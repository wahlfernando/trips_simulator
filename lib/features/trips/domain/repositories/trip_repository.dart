import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/trip.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getTrips();
  Future<Either<Failure, Trip>> getTripDetail(String id);
}
