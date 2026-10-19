import '../utils/app_config.dart';

class ApiConstants {
  static String get baseUrl => AppConfig.apiBaseUrl;
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
