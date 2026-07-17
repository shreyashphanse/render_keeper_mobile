import 'package:flutter/material.dart';

import '../../../../shared/widgets/rk_app_bar.dart';
import '../widgets/overview_card.dart';
import '../widgets/project_card.dart';
import '../../../core/storage/project_repository.dart';
import '../../../shared/models/project_model.dart';
import '../../urls/screens/add_project_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ProjectRepository _repository = ProjectRepository();

  List<ProjectModel> projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final data = _repository.getAllProjects();
    debugPrint("Dashboard loaded ${data.length} projects");

    setState(() {
      projects = data;
    });
  }

  Future<void> _openAddProject() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProjectScreen()),
    );

    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RKAppBar(title: "RenderKeeper"),

      floatingActionButton: FloatingActionButton(
        onPressed: _openAddProject,
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Overview",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              const OverviewCard(),

              const SizedBox(height: 30),

              const Text(
                "Projects",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              if (projects.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "No Projects Added Yet",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              else
                Column(
                  children: projects
                      .map((project) => ProjectCard(project: project))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
