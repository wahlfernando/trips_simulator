import 'package:http/http.dart' as http;
import 'package:trips_simulator/features/trips/domain/datasources/trip_remote_datasource.dart';
import 'features/trips/data/datasources/trip_remote_datasource_http.dart';
import 'features/trips/data/repositories/trip_repository_impl.dart';
import 'features/trips/domain/repositories/trip_repository.dart';
import 'features/trips/domain/usecases/get_trip_detail.dart';
import 'features/trips/domain/usecases/get_trips.dart';

late TripRemoteDataSource tripRemoteDataSource;
late TripRepository tripRepository;
late GetTrips getTripsUseCase;
late GetTripDetail getTripDetailUseCase;

Future<void> init() async {
  final client = http.Client();

  tripRemoteDataSource = TripRemoteDataSourceHttp(client: client);

  tripRepository = TripRepositoryImpl(remoteDataSource: tripRemoteDataSource);

  getTripsUseCase = GetTrips(tripRepository);
  getTripDetailUseCase = GetTripDetail(tripRepository);
}
