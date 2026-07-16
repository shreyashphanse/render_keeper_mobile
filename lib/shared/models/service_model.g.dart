// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModelAdapter extends TypeAdapter<ServiceModel> {
  @override
  final int typeId = 0;

  @override
  ServiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel(
      id: fields[0] as String,
      name: fields[1] as String,
      url: fields[2] as String,
      type: fields[3] as ServiceType,
      enabled: fields[4] as bool,
      online: fields[5] as bool,
      lastPing: fields[6] as DateTime?,
      responseTime: fields[7] as int,
      statusCode: fields[8] as int,
      consecutiveFailures: fields[9] as int,
      lastError: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.enabled)
      ..writeByte(5)
      ..write(obj.online)
      ..writeByte(6)
      ..write(obj.lastPing)
      ..writeByte(7)
      ..write(obj.responseTime)
      ..writeByte(8)
      ..write(obj.statusCode)
      ..writeByte(9)
      ..write(obj.consecutiveFailures)
      ..writeByte(10)
      ..write(obj.lastError);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
