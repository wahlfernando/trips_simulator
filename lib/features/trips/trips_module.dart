import 'package:http/http.dart' as http;
import 'package:trips_simulator/features/trips/data/datasources/trip_remote_datasource_fake.dart';
import 'package:trips_simulator/features/trips/domain/datasources/trip_remote_datasource.dart';
import 'package:trips_simulator/features/trips/presentation/viewmodel/trips_view_model.dart';
import 'data/datasources/trip_remote_datasource_http.dart';
import 'data/repositories/trip_repository_impl.dart';
import 'domain/repositories/trip_repository.dart';
import 'domain/usecases/get_trip_detail.dart';
import 'domain/usecases/get_trips.dart';

class TripsModule {
  late final TripRemoteDataSource _remoteDataSource;
  late final TripRemoteDataSourceFake _remoteDataSourceFake;
  late final TripRepository _repository;
  late final GetTrips _getTrips;
  late final GetTripDetail _getTripDetail;
  late final TripsViewModel _viewModel;

  TripsModule() {
    final client = http.Client();

    _remoteDataSource = TripRemoteDataSourceHttp(client: client);
    _remoteDataSourceFake = TripRemoteDataSourceFake();
    _repository = TripRepositoryImpl(remoteDataSource: _remoteDataSourceFake);
    _getTrips = GetTrips(_repository);
    _getTripDetail = GetTripDetail(_repository);
    _viewModel = TripsViewModel(
      getTrips: _getTrips,
      getTripDetail: _getTripDetail,
    );
  }

  TripsViewModel get viewModel => _viewModel;
}
