import 'package:hive/hive.dart';

part 'streak_data.g.dart';

@HiveType(typeId: 1)
class StreakData {
  @HiveField(0)
  int currentStreak;
  @HiveField(1)
  int highestStreak;
  @HiveField(2)
  DateTime? lastCompletionDate;
  @HiveField(3)
  bool isInRecovery;
  @HiveField(4)
  int recoveryProgress;
  @HiveField(5)
  int recoveryRequired;

  StreakData({
    this.currentStreak = 0,
    this.highestStreak = 0,
    this.lastCompletionDate,
    this.isInRecovery = false,
    this.recoveryProgress = 0,
    this.recoveryRequired = 0,
  });

  StreakData copyWith({
    int? currentStreak,
    int? highestStreak,
    DateTime? lastCompletionDate,
    bool? isInRecovery,
    int? recoveryProgress,
    int? recoveryRequired,
  }) {
    return StreakData(
      currentStreak: currentStreak ?? this.currentStreak,
      highestStreak: highestStreak ?? this.highestStreak,
      lastCompletionDate: lastCompletionDate ?? this.lastCompletionDate,
      isInRecovery: isInRecovery ?? this.isInRecovery,
      recoveryProgress: recoveryProgress ?? this.recoveryProgress,
      recoveryRequired: recoveryRequired ?? this.recoveryRequired,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'highestStreak': highestStreak,
      'lastCompletionDate': lastCompletionDate?.toIso8601String(),
      'isInRecovery': isInRecovery,
      'recoveryProgress': recoveryProgress,
      'recoveryRequired': recoveryRequired,
    };
  }

  factory StreakData.fromJson(Map<String, dynamic> json) {
    return StreakData(
      currentStreak: json['currentStreak'] ?? 0,
      highestStreak: json['highestStreak'] ?? 0,
      lastCompletionDate: json['lastCompletionDate'] != null
          ? DateTime.parse(json['lastCompletionDate'])
          : null,
      isInRecovery: json['isInRecovery'] ?? false,
      recoveryProgress: json['recoveryProgress'] ?? 0,
      recoveryRequired: json['recoveryRequired'] ?? 0,
    );
  }
}
