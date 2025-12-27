import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/trips/presentation/pages/trip_list_page.dart';
import '../../../features/trips/presentation/pages/trip_detail_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String tripDetail = '/trip_detail';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const TripListPage(),
      ),
      GoRoute(
        path: '$tripDetail/:tripId',
        name: 'detail',
        builder: (context, state) {
          final tripId = state.pathParameters['tripId']!;
          return TripDetailPage(tripId: tripId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Página não encontrada: ${state.error}')),
    ),
  );
}
