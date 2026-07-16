import 'package:flutter/material.dart';

class RKStatusBadge extends StatelessWidget {
  final bool online;

  const RKStatusBadge({super.key, required this.online});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: online ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        online ? "ONLINE" : "OFFLINE",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
