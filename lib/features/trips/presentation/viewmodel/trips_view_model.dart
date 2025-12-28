import '../../domain/usecases/get_trip_detail.dart';
import '../../domain/usecases/get_trips.dart';
import '../bloc/trip_list/trip_list_bloc.dart';
import '../bloc/trip_detail/trip_detail_bloc.dart';

class TripsViewModel {
  final GetTrips _getTrips;
  final GetTripDetail _getTripDetail;

  const TripsViewModel({
    required GetTrips getTrips,
    required GetTripDetail getTripDetail,
  }) : _getTrips = getTrips,
       _getTripDetail = getTripDetail;

  TripListBloc createTripListBloc() {
    return TripListBloc(getTrips: _getTrips);
  }

  TripDetailBloc createTripDetailBloc() {
    return TripDetailBloc(getTripDetail: _getTripDetail);
  }
}
