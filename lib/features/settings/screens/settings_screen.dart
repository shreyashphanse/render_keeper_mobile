import 'package:flutter/material.dart';

import '../../../core/constants/settings_options.dart';
import '../../../core/storage/log_repository.dart';
import '../../../core/storage/project_repository.dart';
import '../../../core/storage/settings_repository.dart';
import '../../../shared/models/project_model.dart';
import '../../../shared/models/settings_model.dart';
import '../../../shared/widgets/rk_app_bar.dart';
import '../../../shared/widgets/rk_settings_switch.dart';
import '../../../shared/widgets/rk_settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsRepository settingsRepository = SettingsRepository();
  final ProjectRepository projectRepository = ProjectRepository();
  final LogRepository logRepository = LogRepository();

  late SettingsModel settings;

  int totalProjects = 0;
  int totalServices = 0;
  int totalLogs = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _clearLogs() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear Logs"),
        content: const Text("Are you sure you want to remove all logs?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Clear"),
          ),
        ],
      ),
    );

    if (result == true) {
      await logRepository.clearLogs();
      await loadData();
    }
  }

  Future<void> _deleteProjects() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete All Projects"),
        content: const Text("This will permanently delete every project."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (result == true) {
      await projectRepository.clearAll();
      await loadData();
    }
  }

  Future<void> _selectPingInterval() async {
    final value = await _showNumberPicker(
      title: "Ping Interval",
      values: SettingsOptions.pingIntervals,
      suffix: "min",
      current: settings.pingInterval,
    );

    if (value != null) {
      settings.pingInterval = value;
      await saveSettings();
    }
  }

  Future<void> _selectTimeout() async {
    final value = await _showNumberPicker(
      title: "Timeout",
      values: SettingsOptions.timeouts,
      suffix: "sec",
      current: settings.timeout,
    );

    if (value != null) {
      settings.timeout = value;
      await saveSettings();
    }
  }

  Future<void> _selectRetryAttempts() async {
    final value = await _showNumberPicker(
      title: "Retry Attempts",
      values: SettingsOptions.retryAttempts,
      suffix: "",
      current: settings.maxRetryAttempts,
    );

    if (value != null) {
      settings.maxRetryAttempts = value;
      await saveSettings();
    }
  }

  Future<void> _selectInternetInterval() async {
    final value = await _showNumberPicker(
      title: "Internet Check Interval",
      values: SettingsOptions.internetIntervals,
      suffix: "sec",
      current: settings.internetCheckInterval,
    );

    if (value != null) {
      settings.internetCheckInterval = value;
      await saveSettings();
    }
  }

  Future<void> _selectTheme() async {
    final value = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: SettingsOptions.themes.map((theme) {
              return ListTile(
                title: Text(theme),
                trailing: settings.theme == theme
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => Navigator.pop(context, theme),
              );
            }).toList(),
          ),
        );
      },
    );

    if (value != null) {
      settings.theme = value;
      await saveSettings();
    }
  }

  Future<int?> _showNumberPicker({
    required String title,
    required List<int> values,
    required String suffix,
    required int current,
  }) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: values.map((value) {
              return ListTile(
                title: Text(suffix.isEmpty ? "$value" : "$value $suffix"),
                trailing: value == current ? const Icon(Icons.check) : null,
                onTap: () => Navigator.pop(context, value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> loadData() async {
    settings = settingsRepository.getSettings();

    final List<ProjectModel> projects = projectRepository.getAllProjects();

    totalProjects = projects.length;

    totalServices = 0;

    for (final project in projects) {
      totalServices += project.services.length;
    }

    totalLogs = logRepository.getAllLogs().length;

    setState(() {});
  }

  Future<void> saveSettings() async {
    await settingsRepository.saveSettings(settings);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RKAppBar(title: "Settings"),

      body: RefreshIndicator(
        onRefresh: loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "General",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            RKSettingsTile(
              icon: Icons.schedule,
              title: "Ping Interval",
              value: "${settings.pingInterval} min",
              onTap: () => _selectPingInterval(),
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.timer,
              title: "Timeout",
              value: "${settings.timeout} sec",
              onTap: () => _selectTimeout(),
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.refresh,
              title: "Retry Attempts",
              value: "${settings.maxRetryAttempts}",
              onTap: () => _selectRetryAttempts(),
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.palette,
              title: "Theme",
              value: settings.theme,
              onTap: () => _selectTheme(),
            ),

            const SizedBox(height: 24),

            const Text(
              "Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            RKSettingsSwitch(
              icon: Icons.notifications_active,
              title: "Persistent Notification",
              subtitle: "Keep monitoring active",
              value: settings.persistentNotification,
              onChanged: (value) async {
                settings.persistentNotification = value;
                await saveSettings();
              },
            ),

            const Divider(),

            RKSettingsSwitch(
              icon: Icons.warning_amber,
              title: "Alert on Failure",
              subtitle: "Notify when a service goes offline",
              value: settings.alertOnFailure,
              onChanged: (value) async {
                settings.alertOnFailure = value;
                await saveSettings();
              },
            ),

            const SizedBox(height: 24),

            const Text(
              "System",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            RKSettingsSwitch(
              icon: Icons.power_settings_new,
              title: "Start on Boot",
              subtitle: "Automatically start monitoring",
              value: settings.startOnBoot,
              onChanged: (value) async {
                settings.startOnBoot = value;
                await saveSettings();
              },
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.battery_charging_full,
              title: "Ignore Battery Optimization",
              value: settings.ignoreBatteryOptimization
                  ? "Enabled"
                  : "Disabled",
              onTap: () {},
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.wifi,
              title: "Internet Check Interval",
              value: "${settings.internetCheckInterval} sec",
              onTap: () => _selectInternetInterval(),
            ),
            const SizedBox(height: 24),

            const Text(
              "Data & Logs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            RKSettingsTile(
              icon: Icons.download,
              title: "Export Logs",
              subtitle: "Coming Soon",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Export Logs will be available soon."),
                  ),
                );
              },
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.delete_sweep,
              title: "Clear Logs",
              destructive: true,
              onTap: _clearLogs,
            ),

            const Divider(),

            RKSettingsTile(
              icon: Icons.folder_delete,
              title: "Delete All Projects",
              destructive: true,
              onTap: _deleteProjects,
            ),

            const SizedBox(height: 24),

            const Text(
              "About",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.info_outline),
              title: Text(
                "RenderKeeper Mobile",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Lightweight uptime monitoring for websites, APIs and free-tier services.",
              ),
            ),

            const Divider(),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.verified),
              title: Text("Version"),
              trailing: Text("1.0.0"),
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.storage),
              title: const Text("Projects"),
              trailing: Text("$totalProjects"),
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.dns),
              title: const Text("Services"),
              trailing: Text("$totalServices"),
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.history),
              title: const Text("Logs"),
              trailing: Text("$totalLogs"),
            ),
          ],
        ),
      ),
    );
  }
}
