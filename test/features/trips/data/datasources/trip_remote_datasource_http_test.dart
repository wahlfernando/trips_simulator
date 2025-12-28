import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:trips_simulator/core/constants/base_connect/base_connect.dart';
import 'package:trips_simulator/features/trips/data/datasources/trip_remote_datasource_http.dart';
import 'package:trips_simulator/features/trips/data/models/trip_model.dart';

void main() {
  group('TripRemoteDataSourceHttp', () {
    test('deve retornar lista de TripModel quando statusCode == 200', () async {
      BaseConnect.baseUrl =
          'https://trips-simulator.free.beeceptor.com/api/trips';

      final mockClient = MockClient((request) async {
        expect(request.url.toString(), BaseConnect.baseUrl);

        final responseJson = jsonEncode([
          {
            'id': '1',
            'lineName': 'Linha A',
            'departureTime': '2025-02-10T08:30:00Z',
            'status': 'scheduled',
          },
          {
            'id': '2',
            'lineName': 'Linha B',
            'departureTime': '2025-02-10T09:30:00Z',
            'status': 'in_progress',
          },
        ]);

        return http.Response(responseJson, 200);
      });

      final dataSource = TripRemoteDataSourceHttp(client: mockClient);

      final result = await dataSource.getTrips();

      expect(result, isA<List<TripModel>>());
      expect(result.length, 2);
      expect(result.first.id, '1');
      expect(result.first.lineName, 'Linha A');
    });

    test('deve lançar Exception quando statusCode != 200', () async {
      BaseConnect.baseUrl =
          'https://trips-simulator.free.beeceptor.com/api/trips';

      final mockClient = MockClient((request) async {
        return http.Response('Erro', 500);
      });

      final dataSource = TripRemoteDataSourceHttp(client: mockClient);

      expect(() => dataSource.getTrips(), throwsA(isA<Exception>()));
    });

    test('getTripDetail deve retornar o item correto pelo id', () async {
      BaseConnect.baseUrl =
          'https://trips-simulator.free.beeceptor.com/api/trips';

      final mockClient = MockClient((request) async {
        final responseJson = jsonEncode([
          {
            'id': '1',
            'lineName': 'Linha A',
            'departureTime': '2025-02-10T08:30:00Z',
            'status': 'scheduled',
          },
          {
            'id': '2',
            'lineName': 'Linha B',
            'departureTime': '2025-02-10T09:30:00Z',
            'status': 'finished',
          },
        ]);

        return http.Response(responseJson, 200);
      });

      final dataSource = TripRemoteDataSourceHttp(client: mockClient);

      final detail = await dataSource.getTripDetail('2');

      expect(detail.id, '2');
      expect(detail.lineName, 'Linha B');
    });
  });
}
