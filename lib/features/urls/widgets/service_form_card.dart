import 'package:flutter/material.dart';

class ServiceFormCard extends StatelessWidget {
  const ServiceFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: "Service Name")),

            SizedBox(height: 16),

            TextField(decoration: InputDecoration(labelText: "Service URL")),
          ],
        ),
      ),
    );
  }
}
