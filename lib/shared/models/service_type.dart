import 'package:hive/hive.dart';

part 'service_type.g.dart';

@HiveType(typeId: 2)
enum ServiceType {
  @HiveField(0)
  backend,

  @HiveField(1)
  frontend,

  @HiveField(2)
  api,

  @HiveField(3)
  ocr,

  @HiveField(4)
  database,

  @HiveField(5)
  worker,

  @HiveField(6)
  other,
}

extension ServiceTypeExtension on ServiceType {
  String get label {
    switch (this) {
      case ServiceType.backend:
        return "Backend";
      case ServiceType.frontend:
        return "Frontend";
      case ServiceType.api:
        return "API";
      case ServiceType.ocr:
        return "OCR";
      case ServiceType.database:
        return "Database";
      case ServiceType.worker:
        return "Worker";
      case ServiceType.other:
        return "Other";
    }
  }
}
