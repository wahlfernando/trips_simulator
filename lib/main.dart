import 'package:flutter/material.dart';
import 'features/trips/presentation/pages/trip_list_page.dart';
import 'trip_remote_data_source.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trips Simulate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0781E5)),
        useMaterial3: true,
      ),
      home: const TripListPage(),
    );
  }
}
