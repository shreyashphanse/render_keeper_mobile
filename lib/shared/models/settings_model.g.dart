// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 4;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      pingInterval: fields[0] as int,
      timeout: fields[1] as int,
      maxRetryAttempts: fields[2] as int,
      persistentNotification: fields[3] as bool,
      alertOnFailure: fields[4] as bool,
      startOnBoot: fields[5] as bool,
      ignoreBatteryOptimization: fields[6] as bool,
      internetCheckInterval: fields[7] as int,
      theme: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.pingInterval)
      ..writeByte(1)
      ..write(obj.timeout)
      ..writeByte(2)
      ..write(obj.maxRetryAttempts)
      ..writeByte(3)
      ..write(obj.persistentNotification)
      ..writeByte(4)
      ..write(obj.alertOnFailure)
      ..writeByte(5)
      ..write(obj.startOnBoot)
      ..writeByte(6)
      ..write(obj.ignoreBatteryOptimization)
      ..writeByte(7)
      ..write(obj.internetCheckInterval)
      ..writeByte(8)
      ..write(obj.theme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
