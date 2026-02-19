// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursed_mark.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CursedMarkAdapter extends TypeAdapter<CursedMark> {
  @override
  final int typeId = 2;

  @override
  CursedMark read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CursedMark(
      count: fields[0] as int,
      totalTimesCursed: fields[1] as int,
      totalDaysCursed: fields[2] as int,
      totalRecoveryDays: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CursedMark obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.totalTimesCursed)
      ..writeByte(2)
      ..write(obj.totalDaysCursed)
      ..writeByte(3)
      ..write(obj.totalRecoveryDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CursedMarkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
