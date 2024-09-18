import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({
    required this.isCompleted,
    super.key,
  }) : contentColor = isCompleted ? completedColor : pendingColor;

  final bool isCompleted;
  final Color contentColor;

  static const pendingColor = Color(0xFFFE7A15);
  static const completedColor = Color(0xFF008000);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DtaIcon(
          isCompleted ? Assets.iconsCheck : Assets.iconsWarning,
          color: contentColor,
        ),
        const SizedBox(width: 4),
        Text(
          isCompleted ? 'Completed' : 'Pending',
          style: context.bodySmall?.copyWith(
            color: contentColor,
            fontFamily: Constants.fontKantumruy,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
