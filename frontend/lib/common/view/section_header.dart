import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/underlined_text.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    super.key,
    this.actionText = 'View All',
    this.onActionTap,
    this.dense = false,
  });

  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: Constants.fontDMSerifDisplay,
              fontSize: dense ? 16 : 24,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onActionTap != null)
          Row(
            children: [
              ZoomTapDetector(
                onTap: onActionTap,
                child: UnderlinedText(actionText),
              ),
              const SizedBox(width: 8),
              DtaIcon(
                Assets.iconsArrowForward,
                color: appColors.accent,
                width: 8,
              )
            ],
          ),
      ],
    );
  }
}
