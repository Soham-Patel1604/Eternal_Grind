import 'package:hive/hive.dart';

part 'cursed_mark.g.dart';

@HiveType(typeId: 2)
class CursedMark {
  @HiveField(0)
  int count;
  @HiveField(1)
  int totalTimesCursed;
  @HiveField(2)
  int totalDaysCursed;
  @HiveField(3)
  int totalRecoveryDays;

  CursedMark({
    this.count = 0,
    this.totalTimesCursed = 0,
    this.totalDaysCursed = 0,
    this.totalRecoveryDays = 0,
  });

  bool get isCursed => count > 0;
  bool get isAccountDeletionImminent => count >= 10;

  CursedMark copyWith({
    int? count,
    int? totalTimesCursed,
    int? totalDaysCursed,
    int? totalRecoveryDays,
  }) {
    return CursedMark(
      count: count ?? this.count,
      totalTimesCursed: totalTimesCursed ?? this.totalTimesCursed,
      totalDaysCursed: totalDaysCursed ?? this.totalDaysCursed,
      totalRecoveryDays: totalRecoveryDays ?? this.totalRecoveryDays,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'totalTimesCursed': totalTimesCursed,
      'totalDaysCursed': totalDaysCursed,
      'totalRecoveryDays': totalRecoveryDays,
    };
  }

  factory CursedMark.fromJson(Map<String, dynamic> json) {
    return CursedMark(
      count: json['count'] ?? 0,
      totalTimesCursed: json['totalTimesCursed'] ?? 0,
      totalDaysCursed: json['totalDaysCursed'] ?? 0,
      totalRecoveryDays: json['totalRecoveryDays'] ?? 0,
    );
  }
}
