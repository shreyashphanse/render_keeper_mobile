import 'package:hive/hive.dart';

import '../../shared/models/project_model.dart';
import 'hive_boxes.dart';

class ProjectRepository {
  final Box<ProjectModel> _box = Hive.box<ProjectModel>(HiveBoxes.projects);

  List<ProjectModel> getAllProjects() {
    return _box.values.toList();
  }

  Future<void> addProject(ProjectModel project) async {
    await _box.put(project.id, project);
  }

  Future<void> updateProject(ProjectModel project) async {
    await _box.put(project.id, project);
  }

  Future<void> deleteProject(String id) async {
    await _box.delete(id);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
