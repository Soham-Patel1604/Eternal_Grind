import '../models/cursed_mark.dart';
import '../models/relief_day.dart';

class CurseService {
  static const int _accountDeletionThreshold = 10;

  /// Checks if account should be deleted
  bool shouldDeleteAccount(CursedMark cursedMark) {
    return cursedMark.count >= _accountDeletionThreshold;
  }

  /// Applies a cursed mark (increments count)
  CursedMark applyCurse(CursedMark currentCurse) {
    return currentCurse.copyWith(
      count: currentCurse.count + 1,
      totalTimesCursed: currentCurse.totalTimesCursed + 1,
    );
  }

  /// Removes all cursed marks after successful recovery
  CursedMark removeCurse(CursedMark currentCurse) {
    return currentCurse.copyWith(
      count: 0,
    );
  }

  /// Increments the total days cursed counter
  CursedMark incrementDaysCursed(CursedMark currentCurse) {
    return currentCurse.copyWith(
      totalDaysCursed: currentCurse.totalDaysCursed + 1,
    );
  }

  /// Increments the total recovery days counter
  CursedMark incrementRecoveryDays(CursedMark currentCurse) {
    return currentCurse.copyWith(
      totalRecoveryDays: currentCurse.totalRecoveryDays + 1,
    );
  }

  /// Attempts to consume a relief day to prevent curse
  /// Returns updated relief day data and whether consumption was successful
  (ReliefDay, bool) tryConsumeReliefDay(ReliefDay currentRelief) {
    if (currentRelief.available > 0) {
      final updated = currentRelief.copyWith(
        available: currentRelief.available - 1,
        totalUsed: currentRelief.totalUsed + 1,
      );
      return (updated, true);
    }
    return (currentRelief, false);
  }

  /// Awards a relief day at milestones
  ReliefDay awardReliefDay(ReliefDay currentRelief) {
    return currentRelief.copyWith(
      available: currentRelief.available + 1,
      totalEarned: currentRelief.totalEarned + 1,
    );
  }

  /// Calculates recovery requirement based on cursed mark count
  int calculateRecoveryRequirement(int cursedMarkCount) {
    return cursedMarkCount * 10;
  }

  /// Gets the warning message based on curse count
  String getCurseWarningMessage(int curseCount) {
    if (curseCount >= 9) {
      return "FINAL WARNING: One more failure and your account will be permanently deleted. There is no recovery from this.";
    } else if (curseCount >= 7) {
      return "You carry $curseCount cursed marks. The weight grows heavier. Deletion awaits at 10.";
    } else if (curseCount >= 5) {
      return "You bear $curseCount cursed marks. Each failure compounds. Discipline or deletion.";
    } else if (curseCount >= 3) {
      return "You are marked $curseCount times. The path to recovery grows longer with each failure.";
    } else {
      return "You carry $curseCount cursed mark${curseCount > 1 ? 's' : ''}. Redemption requires ${calculateRecoveryRequirement(curseCount)} consecutive days.";
    }
  }
}
