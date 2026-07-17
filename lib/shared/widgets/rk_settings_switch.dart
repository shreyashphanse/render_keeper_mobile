import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class RKSettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const RKSettingsSwitch({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,

      secondary: Icon(icon, color: AppColors.primary),

      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.textSecondary),
      ),

      value: value,
      onChanged: onChanged,
    );
  }
}
