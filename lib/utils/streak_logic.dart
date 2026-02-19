class StreakLogic {
  static (int, bool) calculateNewStreak(int currentStreak, DateTime? lastTaskDate) {
    if (lastTaskDate == null) {
      return (1, true); // First task ever
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = DateTime(lastTaskDate.year, lastTaskDate.month, lastTaskDate.day);

    if (last.isAtSameMomentAs(today)) {
      return (currentStreak, false); // Already acted today, no streak change
    } else if (last.isAtSameMomentAs(today.subtract(const Duration(days: 1)))) {
      return (currentStreak + 1, true); // Consecutive day
    } else {
      return (1, true); // Streak broken
    }
  }

  static int checkPenalty(DateTime? lastTaskDate) {
    // If user missed yesterday, maybe penalty?
    // For now, let's keep it simple. Penalty is manual or calculated if needed.
    // If we want to show "You missed X days", we can calculate it here.
    return 0; 
  }
}
