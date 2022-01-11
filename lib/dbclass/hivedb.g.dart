// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivedb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PData extends TypeAdapter<ClassDB> {
  @override
  final int typeId = 1;

  @override
  ClassDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassDB()
      ..aname = fields[0] as String?
      ..uname = fields[1] as String?
      ..paswd = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, ClassDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.aname)
      ..writeByte(1)
      ..write(obj.uname)
      ..writeByte(2)
      ..write(obj.paswd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PData &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
