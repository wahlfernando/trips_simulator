import 'package:flutter_test/flutter_test.dart';
import 'package:trips_simulator/core/enums/trip_status.dart';
import 'package:trips_simulator/core/error/failures.dart';
import 'package:trips_simulator/features/trips/data/models/trip_model.dart';
import 'package:trips_simulator/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:trips_simulator/features/trips/domain/datasources/trip_remote_datasource.dart';
import 'package:trips_simulator/features/trips/domain/entities/trip.dart';

class FakeSuccessRemoteDataSource implements TripRemoteDataSource {
  @override
  Future<List<TripModel>> getTrips() async {
    return [
      const TripModel(
        id: '1',
        lineName: 'Linha A',
        departureTime: '2025-02-10T08:30:00Z',
        status: 'scheduled',
      ),
      const TripModel(
        id: '2',
        lineName: 'Linha B',
        departureTime: '2025-02-10T09:30:00Z',
        status: 'in_progress',
      ),
    ];
  }

  @override
  Future<TripModel> getTripDetail(String id) async {
    return const TripModel(
      id: '1',
      lineName: 'Linha A',
      departureTime: '2025-02-10T08:30:00Z',
      status: 'finished',
    );
  }
}

class FakeErrorRemoteDataSource implements TripRemoteDataSource {
  @override
  Future<List<TripModel>> getTrips() async {
    throw Exception('Erro na API');
  }

  @override
  Future<TripModel> getTripDetail(String id) async {
    throw Exception('Erro na API');
  }
}

void main() {
  group('TripRepositoryImpl', () {
    test(
      'getTrips deve retornar Right<List<Trip>> quando datasource tem sucesso',
      () async {
        final repo = TripRepositoryImpl(
          remoteDataSource: FakeSuccessRemoteDataSource(),
        );

        final result = await repo.getTrips();

        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Esperado sucesso'), (trips) {
          expect(trips, isA<List<Trip>>());
          expect(trips.length, 2);
          expect(trips.first.id, '1');
          expect(trips.first.status, TripStatus.scheduled);
        });
      },
    );

    test(
      'getTrips deve retornar Left<ServerFailure> quando datasource falha',
      () async {
        final repo = TripRepositoryImpl(
          remoteDataSource: FakeErrorRemoteDataSource(),
        );

        final result = await repo.getTrips();

        expect(result.isLeft(), isTrue);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
        }, (_) => fail('Esperado falha'));
      },
    );

    test(
      'getTripDetail deve retornar Right<Trip> com mapeamento correto de status e data',
      () async {
        final repo = TripRepositoryImpl(
          remoteDataSource: FakeSuccessRemoteDataSource(),
        );

        final result = await repo.getTripDetail('1');

        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Esperado sucesso'), (trip) {
          expect(trip.id, '1');
          expect(trip.status, TripStatus.finished);
          expect(trip.formattedDepartureDate, '10/02/2025');
          expect(trip.formattedDepartureTime, '08:30');
        });
      },
    );
  });
}
