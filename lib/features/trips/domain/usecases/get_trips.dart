import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetTrips implements UseCase<List<Trip>, NoParams> {
  final TripRepository repository;

  GetTrips(this.repository);

  @override
  Future<Either<Failure, List<Trip>>> call(NoParams params) {
    return repository.getTrips();
  }
}
