import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CursedOverlay extends StatefulWidget {
  final Widget child;

  const CursedOverlay({
    super.key,
    required this.child,
  });

  @override
  State<CursedOverlay> createState() => _CursedOverlayState();
}

class _CursedOverlayState extends State<CursedOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        
        // Darkened overlay
        Container(
          color: AppColors.cursedOverlay,
        ),
        
        // Pulsing red glow
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.cursedRed.withValues(alpha: _animation.value),
                  width: 4,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
