import 'package:flutter/material.dart';

import '../../../core/storage/log_repository.dart';
import '../../../shared/models/log_entry_model.dart';
import '../../../shared/widgets/rk_app_bar.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final LogRepository repository = LogRepository();

  final TextEditingController searchController = TextEditingController();

  List<LogEntryModel> logs = [];
  List<LogEntryModel> filteredLogs = [];

  bool onlyFailures = false;

  @override
  void initState() {
    super.initState();
    loadLogs();
  }

  void loadLogs() {
    logs = repository.getAllLogs();
    applyFilter();
  }

  void applyFilter() {
    final query = searchController.text.toLowerCase();

    filteredLogs = logs.where((log) {
      final matchesSearch =
          log.projectName.toLowerCase().contains(query) ||
          log.serviceName.toLowerCase().contains(query);

      final matchesFailure = !onlyFailures || !log.online;

      return matchesSearch && matchesFailure;
    }).toList();

    setState(() {});
  }

  Future<void> clearLogs() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Clear Logs"),
        content: const Text("Delete all logs?"),
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
      await repository.clearLogs();
      loadLogs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RKAppBar(
        title: "Logs TEST",
        actions: [
          IconButton(onPressed: loadLogs, icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: clearLogs,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          loadLogs();
        },

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (_) => applyFilter(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search project or service...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SwitchListTile(
                value: onlyFailures,
                title: const Text("Show failures only"),
                onChanged: (value) {
                  onlyFailures = value;
                  applyFilter();
                },
              ),
            ),

            Expanded(
              child: filteredLogs.isEmpty
                  ? const Center(
                      child: Text(
                        "THIS IS THE NEW SCREEN",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredLogs.length,
                      itemBuilder: (_, index) {
                        final log = filteredLogs[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),

                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: log.online
                                  ? Colors.green
                                  : Colors.red,
                              child: Icon(
                                log.online ? Icons.check : Icons.close,
                                color: Colors.white,
                              ),
                            ),

                            title: Text(log.serviceName),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(log.projectName),
                                Text(
                                  "${log.statusCode} • ${log.responseTime} ms",
                                ),
                                Text(
                                  log.timestamp.toLocal().toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                if (log.error.isNotEmpty)
                                  Text(
                                    log.error,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
