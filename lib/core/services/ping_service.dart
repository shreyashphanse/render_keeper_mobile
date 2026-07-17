import 'dart:io';

import 'package:http/http.dart' as http;
import '../storage/settings_repository.dart';

class PingResult {
  final bool online;
  final int statusCode;
  final int responseTime;
  final String error;

  PingResult({
    required this.online,
    required this.statusCode,
    required this.responseTime,
    required this.error,
  });
}

class PingService {
  Future<PingResult> ping(String url) async {
    try {
      final uri = Uri.parse(url);

      final stopwatch = Stopwatch()..start();

      final settings = SettingsRepository().getSettings();

      final response = await http
          .get(uri)
          .timeout(Duration(seconds: settings.timeout));
      stopwatch.stop();

      return PingResult(
        online: response.statusCode < 500,
        statusCode: response.statusCode,
        responseTime: stopwatch.elapsedMilliseconds,
        error: "",
      );
    } on SocketException {
      return PingResult(
        online: false,
        statusCode: 0,
        responseTime: 0,
        error: "No Internet",
      );
    } on FormatException {
      return PingResult(
        online: false,
        statusCode: 0,
        responseTime: 0,
        error: "Invalid URL",
      );
    } catch (e) {
      return PingResult(
        online: false,
        statusCode: 0,
        responseTime: 0,
        error: e.toString(),
      );
    }
  }
}
