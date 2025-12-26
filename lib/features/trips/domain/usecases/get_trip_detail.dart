import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetTripDetail implements UseCase<Trip, String> {
  final TripRepository repository;

  GetTripDetail(this.repository);

  @override
  Future<Either<Failure, Trip>> call(String id) {
    return repository.getTripDetail(id);
  }
}
