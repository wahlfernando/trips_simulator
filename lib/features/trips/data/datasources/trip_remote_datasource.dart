import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trips_simulator/core/constants/base_connect/base_connect.dart';
import '../models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<List<TripModel>> getTrips();
  Future<TripModel> getTripDetail(String id);
}

class TripRemoteDataSourceHttp implements TripRemoteDataSource {
  final http.Client client;

  TripRemoteDataSourceHttp({required this.client});

  final _baseUrl = BaseConnect.baseUrl;

  @override
  Future<List<TripModel>> getTrips() async {
    final response = await client.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar viagens: ${response.statusCode}');
    }

    final decoded = json.decode(response.body);

    if (decoded is List) {
      return decoded
          .map((item) => TripModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Formato de resposta inválido');
  }

  @override
  Future<TripModel> getTripDetail(String id) async {
    final trips = await getTrips();
    return trips.firstWhere((t) => t.id == id);
  }
}
