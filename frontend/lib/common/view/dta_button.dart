import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/utils/constants.dart';

class DTAButton extends StatelessWidget {
  const DTAButton.filled({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
  })  : filled = true,
        borderColor = null;

  const DTAButton.outlined({
    super.key,
    required this.text,
    this.onTap,
    this.borderColor,
  })  : filled = false,
        backgroundColor = null;

  final String text;
  final VoidCallback? onTap;
  final bool filled;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                filled ? Colors.transparent : (borderColor ?? appColors.accent),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: filled
              ? (backgroundColor ?? appColors.accent)
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 9),
        child: Text(
          text,
          style: TextStyle(
            color: filled ? appColors.surface : null,
            fontFamily: Constants.fontDMSerifDisplay,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
