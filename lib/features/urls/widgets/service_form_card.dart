import 'package:flutter/material.dart';

import '../../../shared/models/service_type.dart';

class ServiceFormCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController urlController;

  final ServiceType selectedType;

  final ValueChanged<ServiceType?> onTypeChanged;

  final VoidCallback onRemove;

  final bool canRemove;

  const ServiceFormCard({
    super.key,
    required this.nameController,
    required this.urlController,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onRemove,
    required this.canRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<ServiceType>(
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: "Service Type",
                      border: OutlineInputBorder(),
                    ),
                    items: ServiceType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.label),
                      );
                    }).toList(),
                    onChanged: onTypeChanged,
                  ),
                ),

                const SizedBox(width: 12),

                IconButton(
                  onPressed: canRemove ? onRemove : null,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter service name";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Service Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: urlController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter service URL";
                }

                final uri = Uri.tryParse(value);

                if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
                  return "Enter a valid URL";
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Service URL",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
