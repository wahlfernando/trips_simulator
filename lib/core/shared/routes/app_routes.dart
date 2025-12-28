import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trips_simulator/features/trips/presentation/pages/trip_detail_page.dart';
import 'package:trips_simulator/features/trips/presentation/pages/trip_list_page.dart';
import '../../../features/trips/trips_module.dart';

class AppRoutes {
  static const String home = '/';
  static const String tripDetail = '/trip-detail';

  static GoRouter createRouter(TripsModule tripsModule) {
    return GoRouter(
      initialLocation: home,
      routes: [
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) =>
              TripListPage(viewModel: tripsModule.viewModel),
        ),
        GoRoute(
          path: '$tripDetail/:tripId',
          name: 'detail',
          builder: (context, state) {
            final tripId = state.pathParameters['tripId']!;
            return TripDetailPage(
              tripId: tripId,
              viewModel: tripsModule.viewModel,
            );
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text('Página não encontrada: ${state.error}')),
      ),
    );
  }
}
