import 'package:hive/hive.dart';

import '../../shared/models/settings_model.dart';
import 'hive_boxes.dart';

class SettingsRepository {
  // static const String boxName = "settings";
  static const String settingsKey = "app_settings";

  Box<SettingsModel> get _box => Hive.box<SettingsModel>(HiveBoxes.settings);

  SettingsModel getSettings() {
    if (!_box.containsKey(settingsKey)) {
      final defaults = SettingsModel.defaults();
      _box.put(settingsKey, defaults);
      return defaults;
    }

    return _box.get(settingsKey)!;
  }

  Future<void> saveSettings(SettingsModel settings) async {
    await _box.put(settingsKey, settings);
  }

  Future<void> resetDefaults() async {
    await _box.put(settingsKey, SettingsModel.defaults());
  }
}
