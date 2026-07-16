import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';
import 'core/storage/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Database.initialize();

  runApp(const RenderKeeperApp());
}

class RenderKeeperApp extends StatelessWidget {
  const RenderKeeperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RenderKeeper',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppRouter(),
    );
  }
}
