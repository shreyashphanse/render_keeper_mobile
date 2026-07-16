import 'package:flutter/material.dart';

import 'stat_tile.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            StatTile(
              title: "Projects",
              value: "3",
              icon: Icons.folder,
              color: Colors.blue,
            ),
            StatTile(
              title: "Services",
              value: "6",
              icon: Icons.dns,
              color: Colors.orange,
            ),
          ],
        ),
        Row(
          children: const [
            StatTile(
              title: "Online",
              value: "6",
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            StatTile(
              title: "Offline",
              value: "0",
              icon: Icons.cancel,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
