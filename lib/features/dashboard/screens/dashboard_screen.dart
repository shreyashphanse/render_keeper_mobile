import 'package:flutter/material.dart';

import '../../../../shared/widgets/rk_app_bar.dart';
import '../widgets/overview_card.dart';
import '../widgets/project_card.dart';
import '../../../core/constants/demo_data.dart';
import '../../urls/screens/add_project_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RKAppBar(title: "RenderKeeper"),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProjectScreen()),
          );
        },
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

              Column(
                children: demoProjects
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
