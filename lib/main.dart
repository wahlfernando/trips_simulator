import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trips_simulator/core/constants/base_connect/base_connect.dart';
import 'package:trips_simulator/core/shared/routes/app_routes.dart';
import 'package:trips_simulator/features/trips/trips_module.dart';
import 'trip_remote_data_source.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tripsModule = TripsModule();

  runApp(MyApp(tripsModule: tripsModule));
  await dotenv.load(fileName: "config/envs/.env.hml");
  BaseConnect.setBaseUrlFromEnv();
  WidgetsFlutterBinding.ensureInitialized();
  // await di.init();

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final TripsModule tripsModule;

  const MyApp({super.key, required this.tripsModule});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Trips Simulator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: AppRoutes.createRouter(tripsModule),
    );
  }
}
