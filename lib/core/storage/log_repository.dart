import 'package:hive/hive.dart';

import '../../shared/models/log_entry_model.dart';
import 'hive_boxes.dart';

class LogRepository {
  final Box<LogEntryModel> _box = Hive.box<LogEntryModel>(HiveBoxes.logs);

  List<LogEntryModel> getAllLogs() {
    return _box.values.toList().reversed.toList();
  }

  Future<void> addLog(LogEntryModel log) async {
    await _box.put(log.id, log);

    if (_box.length > 1000) {
      final firstKey = _box.keys.first;
      await _box.delete(firstKey);
    }
  }

  Future<void> clearLogs() async {
    await _box.clear();
  }
}
