import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_datasource.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource remoteDataSource;

  TripRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final result = await remoteDataSource.getTrips();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Falha ao buscar viagens'));
    }
  }

  @override
  Future<Either<Failure, Trip>> getTripDetail(String id) async {
    try {
      final result = await remoteDataSource.getTripDetail(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Falha ao buscar detalhes da viagem'));
    }
  }
}
