// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relief_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReliefDayAdapter extends TypeAdapter<ReliefDay> {
  @override
  final int typeId = 3;

  @override
  ReliefDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReliefDay(
      available: fields[0] as int,
      totalEarned: fields[1] as int,
      totalUsed: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReliefDay obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.available)
      ..writeByte(1)
      ..write(obj.totalEarned)
      ..writeByte(2)
      ..write(obj.totalUsed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReliefDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
