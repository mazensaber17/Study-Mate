import 'dart:async';
import 'dart:io';

import 'app_config.dart';

class NetworkService {
  NetworkService._();

  /// Confirms that the device can reach the configured backend, not only Wi-Fi.
  static Future<bool> hasInternetConnection() async {
    try {
      final uri = Uri.parse(AppConfig.supabaseUrl);
      final socket = await Socket.connect(
        uri.host,
        uri.port == 0 ? 443 : uri.port,
        timeout: const Duration(seconds: 4),
      );
      socket.destroy();
      return true;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
