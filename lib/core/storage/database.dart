import 'package:hive_flutter/hive_flutter.dart';

import '../../shared/models/project_model.dart';
import '../../shared/models/service_model.dart';
import '../../shared/models/service_type.dart';

import 'hive_boxes.dart';

class Database {
  Database._();

  static Future<void> initialize() async {
    await Hive.initFlutter();

    print("=== Hive Initialization Started ===");

    print("Adapter 0 registered? ${Hive.isAdapterRegistered(0)}");
    print("Adapter 1 registered? ${Hive.isAdapterRegistered(1)}");
    print("Adapter 2 registered? ${Hive.isAdapterRegistered(2)}");

    try {
      if (!Hive.isAdapterRegistered(2)) {
        print("Registering ServiceTypeAdapter");
        Hive.registerAdapter(ServiceTypeAdapter());
      }

      if (!Hive.isAdapterRegistered(0)) {
        print("Registering ServiceModelAdapter");
        Hive.registerAdapter(ServiceModelAdapter());
      }

      if (!Hive.isAdapterRegistered(1)) {
        print("Registering ProjectModelAdapter");
        Hive.registerAdapter(ProjectModelAdapter());
      }

      print("Opening projects box...");
      await Hive.openBox<ProjectModel>(HiveBoxes.projects);

      print("=== Hive Initialization Complete ===");
    } catch (e, stackTrace) {
      print("Hive initialization failed: $e");
      print(stackTrace.toString());
      rethrow;
    }
  }
}
