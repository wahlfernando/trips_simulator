import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trips_simulator/core/enums/trip_filter.dart';
import 'package:trips_simulator/core/enums/trip_list_status.dart';
import 'package:trips_simulator/core/enums/trip_status.dart';
import 'package:trips_simulator/core/error/failures.dart';
import 'package:trips_simulator/core/usecase/usecase.dart';
import 'package:trips_simulator/features/trips/domain/entities/trip.dart';
import 'package:trips_simulator/features/trips/domain/usecases/get_trips.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_event.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_state.dart';

class MockGetTrips extends Mock implements GetTrips {}

void main() {
  late MockGetTrips mockGetTrips;
  late List<Trip> trips;

  setUp(() {
    mockGetTrips = MockGetTrips();

    trips = [
      Trip(
        id: '1',
        lineName: 'Linha A',
        departureTime: DateTime.parse('2025-02-10T08:30:00Z'),
        status: TripStatus.scheduled,
      ),
      Trip(
        id: '2',
        lineName: 'Linha B',
        departureTime: DateTime.parse('2025-02-10T09:30:00Z'),
        status: TripStatus.inProgress,
      ),
      Trip(
        id: '3',
        lineName: 'Linha C',
        departureTime: DateTime.parse('2025-02-10T10:30:00Z'),
        status: TripStatus.finished,
      ),
    ];
  });

  blocTest<TripListBloc, TripListState>(
    'emite [loading, success] quando TripListRequested tem sucesso',
    build: () {
      when(
        () => mockGetTrips(const NoParams()),
      ).thenAnswer((_) async => Right(trips));
      return TripListBloc(getTrips: mockGetTrips);
    },
    act: (bloc) => bloc.add(TripListRequested()),
    expect: () => [
      const TripListState(status: TripListStatus.loading),
      TripListState(
        status: TripListStatus.success,
        allTrips: trips,
        trips: trips,
      ),
    ],
    verify: (_) {
      verify(() => mockGetTrips(const NoParams())).called(1);
    },
  );

  blocTest<TripListBloc, TripListState>(
    'emite [loading, empty] quando TripListRequested retorna lista vazia',
    build: () {
      when(
        () => mockGetTrips(const NoParams()),
      ).thenAnswer((_) async => const Right([]));
      return TripListBloc(getTrips: mockGetTrips);
    },
    act: (bloc) => bloc.add(TripListRequested()),
    expect: () => [
      const TripListState(status: TripListStatus.loading),
      const TripListState(
        status: TripListStatus.empty,
        trips: [],
        allTrips: [],
      ),
    ],
  );

  blocTest<TripListBloc, TripListState>(
    'emite [loading, failure] quando TripListRequested falha',
    build: () {
      when(
        () => mockGetTrips(const NoParams()),
      ).thenAnswer((_) async => Left(ServerFailure('erro qualquer')));
      return TripListBloc(getTrips: mockGetTrips);
    },
    act: (bloc) => bloc.add(TripListRequested()),
    expect: () => [
      const TripListState(status: TripListStatus.loading),
      const TripListState(
        status: TripListStatus.failure,
        trips: [],
        allTrips: [],
        errorMessage: 'erro qualquer',
      ),
    ],
  );

  blocTest<TripListBloc, TripListState>(
    'aplica filtro corretamente quando ChangeFilterEvent é disparado',
    build: () {
      when(
        () => mockGetTrips(const NoParams()),
      ).thenAnswer((_) async => Right(trips));
      return TripListBloc(getTrips: mockGetTrips);
    },
    act: (bloc) async {
      bloc.add(TripListRequested());
      await Future.delayed(const Duration(milliseconds: 10));
      bloc.add(ChangeFilterEvent(TripFilter.finalizadas));
    },
    expect: () => [
      const TripListState(status: TripListStatus.loading),
      TripListState(
        status: TripListStatus.success,
        allTrips: trips,
        trips: trips,
      ),
      TripListState(
        status: TripListStatus.success,
        allTrips: trips,
        trips: [trips[2]],
        selectedFilter: TripFilter.finalizadas,
      ),
    ],
  );
}
