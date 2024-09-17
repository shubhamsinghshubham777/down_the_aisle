import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/half_onion_dome_clipper.dart';

class HalfOnionDomeContainer extends StatelessWidget {
  const HalfOnionDomeContainer({
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
    this.showOutline = true,
    this.child,
  });

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget? child;
  final bool showOutline;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const HalfOnionDomeClipper(),
      child: CustomPaint(
        foregroundPainter: showOutline ? _OutlinePainter() : null,
        child: Container(
          width: width,
          height: height,
          color: backgroundColor ?? appColors.primaryLight,
          child: child,
        ),
      ),
    );
  }
}

class _OutlinePainter extends CustomPainter {
  final outlinePaint = Paint()
    ..color = appColors.primaryDark.withOpacity(0.2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      const HalfOnionDomeClipper(close: false).getClip(size),
      outlinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
