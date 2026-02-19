import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class StreakCounter extends StatelessWidget {
  final int streak;
  final bool isInRecovery;
  final int recoveryProgress;
  final int recoveryRequired;

  const StreakCounter({
    super.key,
    required this.streak,
    this.isInRecovery = false,
    this.recoveryProgress = 0,
    this.recoveryRequired = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isInRecovery) ...[
          Text(
            'RECOVERY MODE',
            style: AppTextStyles.cursedWarning,
          ),
          const SizedBox(height: 8),
          Text(
            '$recoveryProgress / $recoveryRequired days',
            style: AppTextStyles.cursedStatus,
          ),
          const SizedBox(height: 16),
        ],
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: child,
              ),
            );
          },
          child: Text(
            isInRecovery ? '—' : streak.toString(),
            style: AppTextStyles.streakCounter,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isInRecovery ? 'Seeking Redemption' : 'Day Streak',
          style: AppTextStyles.body.copyWith(
            color: isInRecovery ? AppColors.crimson : AppColors.dimWhite,
          ),
        ),
      ],
    );
  }
}
