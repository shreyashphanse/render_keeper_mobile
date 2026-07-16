import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class RKAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const RKAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
