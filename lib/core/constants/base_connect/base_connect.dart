import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseConnect {
  static late String baseUrl;

  static void setBaseUrlFromEnv() {
    baseUrl = dotenv.env['BASE_URL'] ?? '';
  }
}
