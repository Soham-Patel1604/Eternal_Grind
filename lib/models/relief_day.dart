import 'package:hive/hive.dart';

part 'relief_day.g.dart';

@HiveType(typeId: 3)
class ReliefDay {
  @HiveField(0)
  int available;
  @HiveField(1)
  int totalEarned;
  @HiveField(2)
  int totalUsed;

  ReliefDay({
    this.available = 0,
    this.totalEarned = 0,
    this.totalUsed = 0,
  });

  bool get hasReliefDays => available > 0;

  ReliefDay copyWith({
    int? available,
    int? totalEarned,
    int? totalUsed,
  }) {
    return ReliefDay(
      available: available ?? this.available,
      totalEarned: totalEarned ?? this.totalEarned,
      totalUsed: totalUsed ?? this.totalUsed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'totalEarned': totalEarned,
      'totalUsed': totalUsed,
    };
  }

  factory ReliefDay.fromJson(Map<String, dynamic> json) {
    return ReliefDay(
      available: json['available'] ?? 0,
      totalEarned: json['totalEarned'] ?? 0,
      totalUsed: json['totalUsed'] ?? 0,
    );
  }
}
