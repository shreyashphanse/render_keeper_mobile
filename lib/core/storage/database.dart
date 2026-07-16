import 'package:hive_flutter/hive_flutter.dart';

import '../../shared/models/project_model.dart';
import '../../shared/models/service_model.dart';

import 'hive_boxes.dart';

class Database {
  Database._();

  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ServiceModelAdapter());
    Hive.registerAdapter(ProjectModelAdapter());

    await Hive.openBox<ProjectModel>(HiveBoxes.projects);
  }
}
