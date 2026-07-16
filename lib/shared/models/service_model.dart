import 'package:hive/hive.dart';
import 'service_type.dart';

part 'service_model.g.dart';

@HiveType(typeId: 0)
class ServiceModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final ServiceType type;

  @HiveField(4)
  bool enabled;

  @HiveField(5)
  bool online;

  @HiveField(6)
  DateTime? lastPing;

  @HiveField(7)
  int responseTime;

  @HiveField(8)
  int statusCode;

  @HiveField(9)
  int consecutiveFailures;

  @HiveField(10)
  String lastError;

  ServiceModel({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    this.enabled = true,
    this.online = false,
    this.lastPing,
    this.responseTime = 0,
    this.statusCode = 0,
    this.consecutiveFailures = 0,
    this.lastError = "",
  });
}
