import '../models/streak_data.dart';

class StreakService {
  /// Milestone thresholds and their corresponding messages
  static const Map<int, String> _milestoneMessages = {
    10: "Ten days. Most quit before this. You didn't.",
    20: "Twenty days of discipline. The path reveals itself to those who persist.",
    50: "Fifty days. You have earned respite. Use it wisely.",
    100: "One hundred days. Discipline is no longer a choice—it is who you are.",
    150: "One hundred fifty days. Few reach this summit. Fewer still maintain it.",
  };

  /// Relief day milestones (50, 100, 150)
  static const List<int> _reliefDayMilestones = [50, 100, 150];

  /// Checks if a streak value is a milestone
  bool isMilestone(int streak) {
    return _milestoneMessages.containsKey(streak);
  }

  /// Gets the message for a specific milestone
  String? getMilestoneMessage(int streak) {
    return _milestoneMessages[streak];
  }

  /// Checks if a milestone earns a relief day
  bool earnsReliefDay(int streak) {
    return _reliefDayMilestones.contains(streak);
  }

  /// Increments the streak after all tasks are completed
  StreakData incrementStreak(StreakData currentStreak, DateTime completionDate) {
    final newStreak = currentStreak.currentStreak + 1;
    final newHighest = newStreak > currentStreak.highestStreak 
        ? newStreak 
        : currentStreak.highestStreak;

    return currentStreak.copyWith(
      currentStreak: newStreak,
      highestStreak: newHighest,
      lastCompletionDate: completionDate,
    );
  }

  /// Breaks the streak (sets to 0)
  StreakData breakStreak(StreakData currentStreak) {
    return currentStreak.copyWith(
      currentStreak: 0,
      lastCompletionDate: null,
    );
  }

  /// Increments recovery progress
  StreakData incrementRecovery(StreakData currentStreak, DateTime completionDate) {
    final newProgress = currentStreak.recoveryProgress + 1;
    
    return currentStreak.copyWith(
      recoveryProgress: newProgress,
      lastCompletionDate: completionDate,
    );
  }

  /// Checks if recovery is complete
  bool isRecoveryComplete(StreakData streakData) {
    return streakData.isInRecovery && 
           streakData.recoveryProgress >= streakData.recoveryRequired;
  }

  /// Completes recovery and resets streak
  StreakData completeRecovery(StreakData currentStreak) {
    return currentStreak.copyWith(
      currentStreak: 0,
      isInRecovery: false,
      recoveryProgress: 0,
      recoveryRequired: 0,
      lastCompletionDate: DateTime.now(),
    );
  }

  /// Starts recovery mode
  StreakData startRecovery(StreakData currentStreak, int cursedMarkCount) {
    final requiredDays = cursedMarkCount * 10;
    
    return currentStreak.copyWith(
      isInRecovery: true,
      recoveryProgress: 0,
      recoveryRequired: requiredDays,
      currentStreak: 0,
    );
  }
}
