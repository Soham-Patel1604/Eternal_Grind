import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class StreakHeaderIcon extends StatelessWidget {
  final int streak;
  final bool isInRecovery;

  const StreakHeaderIcon({
    super.key,
    required this.streak,
    this.isInRecovery = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isInRecovery) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.cursedRed.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cursedRed, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded, color: AppColors.cursedRed, size: 18),
            const SizedBox(width: 6),
            Text(
              'RECOVERY',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.cursedRed,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.whatshot, // Flame icon
            color: AppColors.gold,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            streak.toString(),
            style: AppTextStyles.emphasis.copyWith(
              color: AppColors.offWhite,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
