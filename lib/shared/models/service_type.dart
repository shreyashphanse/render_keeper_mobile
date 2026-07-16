enum ServiceType { backend, frontend, api, ocr, database, worker, other }

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
