import 'package:http/http.dart' as http;
import 'package:trips_simulator/features/trips/presentation/viewmodel/trips_view_model.dart';
import 'data/datasources/trip_remote_datasource.dart';
import 'data/repositories/trip_repository_impl.dart';
import 'domain/repositories/trip_repository.dart';
import 'domain/usecases/get_trip_detail.dart';
import 'domain/usecases/get_trips.dart';

class TripsModule {
  late final TripRemoteDataSource _remoteDataSource;
  late final TripRepository _repository;
  late final GetTrips _getTrips;
  late final GetTripDetail _getTripDetail;
  late final TripsViewModel _viewModel;

  TripsModule() {
    final client = http.Client();

    _remoteDataSource = TripRemoteDataSourceHttp(client: client);
    _repository = TripRepositoryImpl(remoteDataSource: _remoteDataSource);
    _getTrips = GetTrips(_repository);
    _getTripDetail = GetTripDetail(_repository);
    _viewModel = TripsViewModel(
      getTrips: _getTrips,
      getTripDetail: _getTripDetail,
    );
  }

  TripsViewModel get viewModel => _viewModel;
}
