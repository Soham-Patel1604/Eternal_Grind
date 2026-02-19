// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreakDataAdapter extends TypeAdapter<StreakData> {
  @override
  final int typeId = 1;

  @override
  StreakData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreakData(
      currentStreak: fields[0] as int,
      highestStreak: fields[1] as int,
      lastCompletionDate: fields[2] as DateTime?,
      isInRecovery: fields[3] as bool,
      recoveryProgress: fields[4] as int,
      recoveryRequired: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StreakData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currentStreak)
      ..writeByte(1)
      ..write(obj.highestStreak)
      ..writeByte(2)
      ..write(obj.lastCompletionDate)
      ..writeByte(3)
      ..write(obj.isInRecovery)
      ..writeByte(4)
      ..write(obj.recoveryProgress)
      ..writeByte(5)
      ..write(obj.recoveryRequired);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreakDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
