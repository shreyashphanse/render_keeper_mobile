import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class RKCard extends StatelessWidget {
  final Widget child;

  const RKCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );
  }
}
