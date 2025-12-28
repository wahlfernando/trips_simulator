import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_datasource.dart';
import '../mappers/trip_mapper.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource remoteDataSource;

  TripRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final models = await remoteDataSource.getTrips();
      final entities = TripMapper.fromModelListToEntityList(models);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure('Falha ao buscar viagens'));
    }
  }

  @override
  Future<Either<Failure, Trip>> getTripDetail(String id) async {
    try {
      final model = await remoteDataSource.getTripDetail(id);
      final entity = TripMapper.fromDTOToEntity(
        TripMapper.fromModelToDTO(model),
      );
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure('Falha ao buscar detalhes da viagem'));
    }
  }
}
