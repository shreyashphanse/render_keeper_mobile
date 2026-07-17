import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final bool online;
  final int statusCode;
  final int responseTime;

  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.online,
    required this.statusCode,
    required this.responseTime,
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
        subtitle: Row(
          children: [
            Text("HTTP $statusCode"),

            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: responseTime < 200
                    ? Colors.green
                    : responseTime < 600
                    ? Colors.orange
                    : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$responseTime ms",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
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
