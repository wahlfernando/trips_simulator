import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseConnect {
  static const String envPath = 'config/envs/.env';
  static late String baseUrl;

  static void setBaseUrlFromEnv() {
    baseUrl = dotenv.env['BASE_URL'] ?? '';
  }
}
