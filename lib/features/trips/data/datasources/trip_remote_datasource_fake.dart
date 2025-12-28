import '../../domain/datasources/trip_remote_datasource.dart';
import '../models/trip_model.dart';

class TripRemoteDataSourceFake implements TripRemoteDataSource {
  TripRemoteDataSourceFake();

  @override
  Future<List<TripModel>> getTrips() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final fakeData = [
      {
        "id": "1",
        "lineName": "Expresso Leste",
        "departureTime": "2025-12-28T08:30:00",
        "status": "in_progress",
      },
      {
        "id": "2",
        "lineName": "Linha Sul - Direta",
        "departureTime": "2025-12-28T09:15:00",
        "status": "finished",
      },
      {
        "id": "3",
        "lineName": "Circular Central",
        "departureTime": "2025-12-28T10:00:00",
        "status": "scheduled",
      },
      {
        "id": "4",
        "lineName": "Intermunicipal 402",
        "departureTime": "2025-12-28T10:45:00",
        "status": "in_progress",
      },
      {
        "id": "5",
        "lineName": "Linha Norte - Rápida",
        "departureTime": "2025-12-28T11:30:00",
        "status": "finished",
      },
      {
        "id": "6",
        "lineName": "Linha Santa Maria",
        "departureTime": "2025-12-28T12:00:00",
        "status": "scheduled",
      },
      {
        "id": "7",
        "lineName": "Expresso Oeste",
        "departureTime": "2025-12-28T13:00:00",
        "status": "in_progress",
      },
      {
        "id": "8",
        "lineName": "Linha Aeroporto",
        "departureTime": "2025-12-28T14:15:00",
        "status": "scheduled",
      },
      {
        "id": "9",
        "lineName": "Circular Noturna",
        "departureTime": "2025-12-28T15:30:00",
        "status": "finished",
      },
      {
        "id": "10",
        "lineName": "Intermunicipal 505",
        "departureTime": "2025-12-28T16:00:00",
        "status": "in_progress",
      },
      {
        "id": "11",
        "lineName": "Linha Universitária",
        "departureTime": "2025-12-28T17:45:00",
        "status": "scheduled",
      },
    ];

    return fakeData.map((item) => TripModel.fromJson(item)).toList();
  }

  @override
  Future<TripModel> getTripDetail(String id) async {
    final trips = await getTrips();
    return trips.firstWhere((t) => t.id == id);
  }
}
