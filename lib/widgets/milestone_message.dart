import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';

class MilestoneMessage extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const MilestoneMessage({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.charcoal,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.gold, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.gold,
                size: 48,
              ),
              const SizedBox(height: 24),
              
              Text(
                'MILESTONE REACHED',
                style: AppTextStyles.h3.copyWith(color: AppColors.gold),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                message,
                style: AppTextStyles.milestone,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              TextButton(
                onPressed: onDismiss,
                child: Text(
                  'Continue',
                  style: AppTextStyles.button.copyWith(color: AppColors.gold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
