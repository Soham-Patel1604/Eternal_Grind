import 'package:hive/hive.dart';
import 'streak_data.dart';
import 'cursed_mark.dart';
import 'relief_day.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile {
  @HiveField(0)
  StreakData streakData;
  @HiveField(1)
  CursedMark cursedMark;
  @HiveField(2)
  ReliefDay reliefDay;
  @HiveField(3)
  int totalActiveDays;
  @HiveField(4)
  DateTime accountCreatedDate;
  @HiveField(5)
  DateTime? lastOpenedDate;
  @HiveField(6)
  bool isFirstDay;

  UserProfile({
    required this.streakData,
    required this.cursedMark,
    required this.reliefDay,
    this.totalActiveDays = 0,
    required this.accountCreatedDate,
    this.lastOpenedDate,
    this.isFirstDay = true,
  });

  factory UserProfile.initial() {
    return UserProfile(
      streakData: StreakData(),
      cursedMark: CursedMark(),
      reliefDay: ReliefDay(),
      totalActiveDays: 0,
      accountCreatedDate: DateTime.now(),
      lastOpenedDate: null,
      isFirstDay: true,
    );
  }

  UserProfile copyWith({
    StreakData? streakData,
    CursedMark? cursedMark,
    ReliefDay? reliefDay,
    int? totalActiveDays,
    DateTime? accountCreatedDate,
    DateTime? lastOpenedDate,
    bool? isFirstDay,
  }) {
    return UserProfile(
      streakData: streakData ?? this.streakData,
      cursedMark: cursedMark ?? this.cursedMark,
      reliefDay: reliefDay ?? this.reliefDay,
      totalActiveDays: totalActiveDays ?? this.totalActiveDays,
      accountCreatedDate: accountCreatedDate ?? this.accountCreatedDate,
      lastOpenedDate: lastOpenedDate ?? this.lastOpenedDate,
      isFirstDay: isFirstDay ?? this.isFirstDay,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'streakData': streakData.toJson(),
      'cursedMark': cursedMark.toJson(),
      'reliefDay': reliefDay.toJson(),
      'totalActiveDays': totalActiveDays,
      'accountCreatedDate': accountCreatedDate.toIso8601String(),
      'lastOpenedDate': lastOpenedDate?.toIso8601String(),
      'isFirstDay': isFirstDay,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      streakData: StreakData.fromJson(json['streakData']),
      cursedMark: CursedMark.fromJson(json['cursedMark']),
      reliefDay: ReliefDay.fromJson(json['reliefDay']),
      totalActiveDays: json['totalActiveDays'] ?? 0,
      accountCreatedDate: DateTime.parse(json['accountCreatedDate']),
      lastOpenedDate: json['lastOpenedDate'] != null
          ? DateTime.parse(json['lastOpenedDate'])
          : null,
      isFirstDay: json['isFirstDay'] ?? true,
    );
  }
}
