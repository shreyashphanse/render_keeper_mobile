import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final bool online;

  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF263449),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(
          online ? Icons.check_circle : Icons.cancel,
          color: online ? Colors.green : Colors.red,
        ),
        title: Text(serviceName),
        trailing: Text(
          online ? "ONLINE" : "OFFLINE",
          style: TextStyle(
            color: online ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
