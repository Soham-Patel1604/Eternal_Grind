// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      streakData: fields[0] as StreakData,
      cursedMark: fields[1] as CursedMark,
      reliefDay: fields[2] as ReliefDay,
      totalActiveDays: fields[3] as int,
      accountCreatedDate: fields[4] as DateTime,
      lastOpenedDate: fields[5] as DateTime?,
      isFirstDay: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.streakData)
      ..writeByte(1)
      ..write(obj.cursedMark)
      ..writeByte(2)
      ..write(obj.reliefDay)
      ..writeByte(3)
      ..write(obj.totalActiveDays)
      ..writeByte(4)
      ..write(obj.accountCreatedDate)
      ..writeByte(5)
      ..write(obj.lastOpenedDate)
      ..writeByte(6)
      ..write(obj.isFirstDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
