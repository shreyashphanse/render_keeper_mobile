import 'package:flutter/material.dart';

import '../widgets/service_form_card.dart';
import '../../../shared/models/service_type.dart';
import '../../../core/storage/project_repository.dart';
import '../../../core/utils/id_generator.dart';
import '../../../shared/models/project_model.dart';
import '../../../shared/models/service_model.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final ProjectRepository _repository = ProjectRepository();
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();

  final List<TextEditingController> serviceNameControllers = [
    TextEditingController(),
  ];

  final List<TextEditingController> serviceUrlControllers = [
    TextEditingController(),
  ];
  final List<ServiceType> serviceTypes = [ServiceType.backend];

  @override
  void dispose() {
    _projectNameController.dispose();

    for (final controller in serviceNameControllers) {
      controller.dispose();
    }

    for (final controller in serviceUrlControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> _saveProject() async {
    final services = <ServiceModel>[];

    for (int i = 0; i < serviceNameControllers.length; i++) {
      services.add(
        ServiceModel(
          id: IdGenerator.generate(),
          name: serviceNameControllers[i].text.trim(),
          url: serviceUrlControllers[i].text.trim(),
          type: serviceTypes[i],
          online: false,
        ),
      );
    }

    final project = ProjectModel(
      id: IdGenerator.generate(),
      name: _projectNameController.text.trim(),
      services: services,
    );

    await _repository.addProject(project);

    debugPrint("Saved project: ${project.name}");
    debugPrint("Projects in box: ${_repository.getAllProjects().length}");

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Project")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _projectNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter project name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Project Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Column(
                children: List.generate(
                  serviceNameControllers.length,
                  (index) => ServiceFormCard(
                    nameController: serviceNameControllers[index],
                    urlController: serviceUrlControllers[index],

                    selectedType: serviceTypes[index],

                    onTypeChanged: (value) {
                      if (value != null) {
                        setState(() {
                          serviceTypes[index] = value;
                        });
                      }
                    },

                    onRemove: () {
                      setState(() {
                        serviceNameControllers.removeAt(index);
                        serviceUrlControllers.removeAt(index);
                        serviceTypes.removeAt(index);
                      });
                    },

                    canRemove: serviceNameControllers.length > 1,
                  ),
                ),
              ),

              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    serviceNameControllers.add(TextEditingController());

                    serviceUrlControllers.add(TextEditingController());

                    serviceTypes.add(ServiceType.backend);
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Service"),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _saveProject();
                    }
                  },
                  child: const Text("Save Project"),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
