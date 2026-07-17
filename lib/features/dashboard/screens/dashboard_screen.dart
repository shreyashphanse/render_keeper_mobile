import 'package:flutter/material.dart';

import '../../../../shared/widgets/rk_app_bar.dart';
import '../widgets/overview_card.dart';
import '../widgets/project_card.dart';
import '../../../core/storage/project_repository.dart';
import '../../../shared/models/project_model.dart';
import '../../urls/screens/add_project_screen.dart';
import '../../../core/services/ping_service.dart';
import '../../../shared/models/service_model.dart';
import 'dart:async';
import '../../../core/storage/log_repository.dart';
import '../../../shared/models/log_entry_model.dart';
import '../../../core/storage/settings_repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ProjectRepository _repository = ProjectRepository();
  final PingService _pingService = PingService();
  final LogRepository _logRepository = LogRepository();
  Timer? _refreshTimer;
  bool _autoRefreshEnabled = true;

  List<ProjectModel> projects = [];

  @override
  void initState() {
    super.initState();

    _loadProjects();
    _refreshServices();

    _startAutoRefresh();
  }

  Future<void> _refreshServices() async {
    for (final project in projects) {
      final List<ServiceModel> updatedServices = [];

      for (final service in project.services) {
        final result = await _pingService.ping(service.url);

        service.online = result.online;
        service.statusCode = result.statusCode;
        service.responseTime = result.responseTime;
        service.lastError = result.error;
        service.lastPing = DateTime.now();

        final statusChanged =
            service.online != result.online ||
            service.statusCode != result.statusCode ||
            service.lastError != result.error;

        service.online = result.online;
        service.statusCode = result.statusCode;
        service.responseTime = result.responseTime;
        service.lastError = result.error;
        service.lastPing = DateTime.now();

        if (statusChanged) {
          await _logRepository.addLog(
            LogEntryModel(
              id: "${DateTime.now().microsecondsSinceEpoch}_${service.id}",
              projectId: project.id,
              projectName: project.name,
              serviceId: service.id,
              serviceName: service.name,
              timestamp: DateTime.now(),
              online: result.online,
              statusCode: result.statusCode,
              responseTime: result.responseTime,
              error: result.error,
            ),
          );
        }

        updatedServices.add(service);
      }

      await _repository.updateProject(project);
    }

    await _loadProjects();
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();

    if (!_autoRefreshEnabled) return;

    final settings = SettingsRepository().getSettings();

    _refreshTimer = Timer.periodic(
      Duration(minutes: settings.pingInterval),
      (_) => _refreshServices(),
    );
  }

  void _toggleAutoRefresh() {
    setState(() {
      _autoRefreshEnabled = !_autoRefreshEnabled;
    });

    _startAutoRefresh();
  }

  Future<void> _deleteProject(ProjectModel project) async {
    await _repository.deleteProject(project.id);

    await _loadProjects();
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
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RKAppBar(
        title: "RenderKeeper",
        actions: [
          IconButton(
            tooltip: "Refresh Now",
            icon: const Icon(Icons.refresh),
            onPressed: _refreshServices,
          ),

          IconButton(
            tooltip: _autoRefreshEnabled
                ? "Disable Auto Refresh"
                : "Enable Auto Refresh",
            icon: Icon(_autoRefreshEnabled ? Icons.sync : Icons.sync_disabled),
            onPressed: _toggleAutoRefresh,
          ),
        ],
      ),

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
                      .map(
                        (project) => ProjectCard(
                          project: project,
                          onDelete: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Project"),
                                content: Text(
                                  'Are you sure you want to delete "${project.name}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true) {
                              await _deleteProject(project);
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
