import 'package:flutter/material.dart';

import '../../../core/storage/project_repository.dart';
import '../../../shared/models/project_model.dart';
import '../../../shared/models/service_model.dart';
import '../../../shared/models/service_type.dart';
import '../../../shared/widgets/rk_app_bar.dart';
import '../../../shared/widgets/rk_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final ProjectRepository repository = ProjectRepository();

  List<ProjectModel> projects = [];

  int totalProjects = 0;
  int totalServices = 0;
  int onlineServices = 0;
  int offlineServices = 0;

  int averageResponse = 0;
  int fastestResponse = 0;
  int slowestResponse = 0;

  final Map<int, int> statusCodes = {};
  final Map<ServiceType, int> serviceTypes = {};

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    projects = repository.getAllProjects();

    totalProjects = projects.length;
    totalServices = 0;
    onlineServices = 0;
    offlineServices = 0;

    averageResponse = 0;
    fastestResponse = 999999;
    slowestResponse = 0;

    statusCodes.clear();
    serviceTypes.clear();

    int totalResponse = 0;

    for (final project in projects) {
      for (final ServiceModel service in project.services) {
        totalServices++;

        if (service.online) {
          onlineServices++;
        } else {
          offlineServices++;
        }

        if (service.responseTime > 0) {
          totalResponse += service.responseTime;

          if (service.responseTime < fastestResponse) {
            fastestResponse = service.responseTime;
          }

          if (service.responseTime > slowestResponse) {
            slowestResponse = service.responseTime;
          }
        }

        statusCodes.update(
          service.statusCode,
          (value) => value + 1,
          ifAbsent: () => 1,
        );

        serviceTypes.update(
          service.type,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }

    if (totalServices > 0) {
      averageResponse = totalResponse ~/ totalServices;
    }

    if (fastestResponse == 999999) {
      fastestResponse = 0;
    }

    setState(() {});
  }

  double get successRate {
    if (totalServices == 0) return 0;

    return (onlineServices / totalServices) * 100;
  }

  Widget buildTile(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: RKCard(
        child: Column(
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RKAppBar(
        title: "Statistics",
        actions: [
          IconButton(
            onPressed: loadStatistics,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: loadStatistics,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Row(
              children: [
                buildTile(
                  "Projects",
                  "$totalProjects",
                  Icons.folder,
                  Colors.blue,
                ),
                const SizedBox(width: 12),
                buildTile(
                  "Services",
                  "$totalServices",
                  Icons.dns,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                buildTile(
                  "Online",
                  "$onlineServices",
                  Icons.check_circle,
                  Colors.green,
                ),
                const SizedBox(width: 12),
                buildTile(
                  "Offline",
                  "$offlineServices",
                  Icons.cancel,
                  Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 20),

            RKCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Performance",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  const SizedBox(height: 20),

                  ListTile(
                    leading: const Icon(Icons.speed),
                    title: const Text("Average Response"),
                    trailing: Text("$averageResponse ms"),
                  ),

                  ListTile(
                    leading: const Icon(Icons.flash_on),
                    title: const Text("Fastest"),
                    trailing: Text("$fastestResponse ms"),
                  ),

                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: const Text("Slowest"),
                    trailing: Text("$slowestResponse ms"),
                  ),

                  ListTile(
                    leading: const Icon(Icons.verified),
                    title: const Text("Success Rate"),
                    trailing: Text("${successRate.toStringAsFixed(1)}%"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            RKCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "HTTP Status Codes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  const SizedBox(height: 15),

                  if (statusCodes.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("No status code data available."),
                    )
                  else
                    ...statusCodes.entries.map(
                      (entry) => ListTile(
                        leading: CircleAvatar(
                          child: Text(entry.key.toString()),
                        ),
                        title: Text("HTTP ${entry.key}"),
                        trailing: Text("${entry.value}"),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            RKCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Service Types",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  const SizedBox(height: 15),

                  if (serviceTypes.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("No service type data available."),
                    )
                  else
                    ...serviceTypes.entries.map(
                      (entry) => ListTile(
                        leading: const Icon(Icons.layers),
                        title: Text(entry.key.label),
                        trailing: Text("${entry.value}"),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (totalProjects == 0)
              const RKCard(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        Icon(Icons.bar_chart, size: 60, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "No statistics available yet.",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Add a project and refresh your services to generate statistics.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
