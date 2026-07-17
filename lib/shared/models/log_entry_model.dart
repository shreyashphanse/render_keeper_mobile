import 'package:hive/hive.dart';

part 'log_entry_model.g.dart';

@HiveType(typeId: 3)
class LogEntryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String projectId;

  @HiveField(2)
  final String projectName;

  @HiveField(3)
  final String serviceId;

  @HiveField(4)
  final String serviceName;

  @HiveField(5)
  final DateTime timestamp;

  @HiveField(6)
  final bool online;

  @HiveField(7)
  final int statusCode;

  @HiveField(8)
  final int responseTime;

  @HiveField(9)
  final String error;

  LogEntryModel({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.serviceId,
    required this.serviceName,
    required this.timestamp,
    required this.online,
    required this.statusCode,
    required this.responseTime,
    required this.error,
  });
}
