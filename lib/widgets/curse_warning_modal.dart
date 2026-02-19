import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class CurseWarningModal extends StatelessWidget {
  final int curseCount;
  final String warningMessage;
  final VoidCallback onDismiss;

  const CurseWarningModal({
    super.key,
    required this.curseCount,
    required this.warningMessage,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.pureBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.cursedRed, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Skull icon
            const Icon(
              Icons.warning_amber_rounded,
              size: 64,
              color: AppColors.cursedRed,
            ),
            const SizedBox(height: 16),
            
            // Curse count
            Text(
              'CURSED',
              style: AppTextStyles.h2.copyWith(color: AppColors.cursedRed),
            ),
            const SizedBox(height: 8),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                curseCount.clamp(0, 10),
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.close,
                    color: AppColors.cursedRed,
                    size: 20,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Warning message
            Text(
              warningMessage,
              style: AppTextStyles.body.copyWith(
                color: AppColors.offWhite,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Dismiss button
            ElevatedButton(
              onPressed: onDismiss,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cursedRed,
              ),
              child: Text('I Understand', style: AppTextStyles.button),
            ),
          ],
        ),
      ),
    );
  }
}
