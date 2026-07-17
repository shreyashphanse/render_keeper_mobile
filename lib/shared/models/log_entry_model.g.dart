// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogEntryModelAdapter extends TypeAdapter<LogEntryModel> {
  @override
  final int typeId = 3;

  @override
  LogEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogEntryModel(
      id: fields[0] as String,
      projectId: fields[1] as String,
      projectName: fields[2] as String,
      serviceId: fields[3] as String,
      serviceName: fields[4] as String,
      timestamp: fields[5] as DateTime,
      online: fields[6] as bool,
      statusCode: fields[7] as int,
      responseTime: fields[8] as int,
      error: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogEntryModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.projectId)
      ..writeByte(2)
      ..write(obj.projectName)
      ..writeByte(3)
      ..write(obj.serviceId)
      ..writeByte(4)
      ..write(obj.serviceName)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.online)
      ..writeByte(7)
      ..write(obj.statusCode)
      ..writeByte(8)
      ..write(obj.responseTime)
      ..writeByte(9)
      ..write(obj.error);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
