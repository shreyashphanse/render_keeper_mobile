// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceTypeAdapter extends TypeAdapter<ServiceType> {
  @override
  final int typeId = 2;

  @override
  ServiceType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServiceType.backend;
      case 1:
        return ServiceType.frontend;
      case 2:
        return ServiceType.api;
      case 3:
        return ServiceType.ocr;
      case 4:
        return ServiceType.database;
      case 5:
        return ServiceType.worker;
      case 6:
        return ServiceType.other;
      default:
        return ServiceType.backend;
    }
  }

  @override
  void write(BinaryWriter writer, ServiceType obj) {
    switch (obj) {
      case ServiceType.backend:
        writer.writeByte(0);
        break;
      case ServiceType.frontend:
        writer.writeByte(1);
        break;
      case ServiceType.api:
        writer.writeByte(2);
        break;
      case ServiceType.ocr:
        writer.writeByte(3);
        break;
      case ServiceType.database:
        writer.writeByte(4);
        break;
      case ServiceType.worker:
        writer.writeByte(5);
        break;
      case ServiceType.other:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
