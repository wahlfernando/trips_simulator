import 'package:equatable/equatable.dart';
import '../../../../../core/enums/trip_filter.dart';
import '../../../domain/entities/trip.dart';
import '../../../../../core/enums/trip_list_status.dart';

class TripListState extends Equatable {
  final TripListStatus status;
  final List<Trip> trips;
  final String? errorMessage;
  final TripFilter selectedFilter;

  const TripListState({
    this.status = TripListStatus.initial,
    this.trips = const [],
    this.errorMessage,
    this.selectedFilter = TripFilter.todas,
  });

  TripListState copyWith({
    TripListStatus? status,
    List<Trip>? trips,
    String? errorMessage,
    TripFilter? selectedFilter,
  }) {
    return TripListState(
      status: status ?? this.status,
      trips: trips ?? this.trips,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [status, trips, errorMessage, selectedFilter];
}
