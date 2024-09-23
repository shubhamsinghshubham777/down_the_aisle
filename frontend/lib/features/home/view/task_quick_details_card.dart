import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';
import 'package:intl/intl.dart';

class TaskQuickDetailsCard extends StatelessWidget {
  const TaskQuickDetailsCard({
    required this.title,
    required this.value,
    required this.valueUnit,
    required this.dateTime,
    required this.iconAsset,
    required this.onTap,
    super.key,
  });

  final String title;
  final String value;
  final String valueUnit;
  final DateTime dateTime;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appColors.primaryLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.bodySmall?.copyWith(
                    fontFamily: Constants.fontKantumruy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: appColors.accent,
                  size: 16,
                ),
              ],
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: value,
                  style: context.displayLarge?.copyWith(
                    color: appColors.primaryDark,
                    fontSize: 56,
                    fontFamily: Constants.fontDMSerifDisplay,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: ' $valueUnit',
                      style: context.titleMedium?.copyWith(
                        color: appColors.primaryDark,
                        fontFamily: Constants.fontDMSerifDisplay,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(dateTime),
                  style: context.bodySmall?.copyWith(
                    color: appColors.secondaryDark.withOpacity(0.8),
                    fontFamily: Constants.fontKantumruy,
                  ),
                ),
                DtaIcon(
                  Assets.iconCalendar,
                  color: appColors.secondaryDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
