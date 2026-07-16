import 'package:flutter/material.dart';

import '../../../shared/models/project_model.dart';
import 'service_card.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        onExpansionChanged: (value) {
          setState(() {
            expanded = value;
          });
        },

        title: Text(
          widget.project.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        subtitle: Text("${widget.project.services.length} Services"),

        children: widget.project.services
            .map(
              (service) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ServiceCard(
                  serviceName: service.name,
                  online: service.online,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
