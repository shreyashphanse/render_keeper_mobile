import 'package:flutter/material.dart';

import '../widgets/service_form_card.dart';
import '../../../shared/models/service_type.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Validation Successful")),
                      );
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
