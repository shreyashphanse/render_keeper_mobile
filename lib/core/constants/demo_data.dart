import '../../shared/models/project_model.dart';
import '../../shared/models/service_model.dart';
import '../../shared/models/service_type.dart';

final demoProjects = [
  ProjectModel(
    id: "1",
    name: "SaveMyBill",
    services: [
      ServiceModel(
        id: "1",
        name: "Backend",
        url: "",
        type: ServiceType.backend,
        online: true,
      ),
      ServiceModel(
        id: "2",
        name: "OCR",
        url: "",
        type: ServiceType.ocr,
        online: true,
      ),
    ],
  ),

  ProjectModel(
    id: "2",
    name: "Portfolio",
    services: [
      ServiceModel(
        id: "3",
        name: "Backend",
        url: "",
        type: ServiceType.backend,
        online: true,
      ),
      ServiceModel(
        id: "4",
        name: "Frontend",
        url: "",
        type: ServiceType.frontend,
        online: true,
      ),
    ],
  ),

  ProjectModel(
    id: "3",
    name: "LocalSathi",
    services: [
      ServiceModel(
        id: "5",
        name: "Backend",
        url: "",
        type: ServiceType.backend,
        online: true,
      ),
      ServiceModel(
        id: "6",
        name: "Frontend",
        url: "",
        type: ServiceType.frontend,
        online: true,
      ),
    ],
  ),
];
