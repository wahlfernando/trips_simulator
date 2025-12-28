import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trips_simulator/core/enums/trip_status.dart';
import 'package:trips_simulator/core/error/failures.dart';
import 'package:trips_simulator/core/usecase/usecase.dart';
import 'package:trips_simulator/features/trips/domain/entities/trip.dart';
import 'package:trips_simulator/features/trips/domain/repositories/trip_repository.dart';
import 'package:trips_simulator/features/trips/domain/usecases/get_trips.dart';

class FakeSuccessTripRepository implements TripRepository {
  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    return Right([
      Trip(
        id: '1',
        lineName: 'Linha A',
        departureTime: DateTime.parse('2025-02-10T08:30:00Z'),
        status: TripStatus.scheduled,
      ),
    ]);
  }

  @override
  Future<Either<Failure, Trip>> getTripDetail(String id) {
    throw UnimplementedError();
  }
}

void main() {
  group('GetTrips UseCase', () {
    test(
      'deve delegar chamada para o repositório e retornar lista de Trip',
      () async {
        final repo = FakeSuccessTripRepository();
        final usecase = GetTrips(repo);

        final result = await usecase(const NoParams());

        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Esperado sucesso'), (trips) {
          expect(trips.length, 1);
          expect(trips.first.lineName, 'Linha A');
        });
      },
    );
  });
}
