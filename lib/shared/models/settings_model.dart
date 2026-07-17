import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 4)
class SettingsModel {
  @HiveField(0)
  int pingInterval;

  @HiveField(1)
  int timeout;

  @HiveField(2)
  int maxRetryAttempts;

  @HiveField(3)
  bool persistentNotification;

  @HiveField(4)
  bool alertOnFailure;

  @HiveField(5)
  bool startOnBoot;

  @HiveField(6)
  bool ignoreBatteryOptimization;

  @HiveField(7)
  int internetCheckInterval;

  @HiveField(8)
  String theme;

  SettingsModel({
    required this.pingInterval,
    required this.timeout,
    required this.maxRetryAttempts,
    required this.persistentNotification,
    required this.alertOnFailure,
    required this.startOnBoot,
    required this.ignoreBatteryOptimization,
    required this.internetCheckInterval,
    required this.theme,
  });

  factory SettingsModel.defaults() {
    return SettingsModel(
      pingInterval: 10,
      timeout: 10,
      maxRetryAttempts: 3,
      persistentNotification: true,
      alertOnFailure: true,
      startOnBoot: false,
      ignoreBatteryOptimization: false,
      internetCheckInterval: 30,
      theme: "Dark",
    );
  }
}
