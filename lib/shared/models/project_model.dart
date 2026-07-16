import 'package:hive/hive.dart';

import 'service_model.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class ProjectModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<ServiceModel> services;

  ProjectModel({required this.id, required this.name, required this.services});
}
