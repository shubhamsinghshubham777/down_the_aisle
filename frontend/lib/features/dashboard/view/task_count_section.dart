import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_app_bar.dart';
import 'package:frontend/common/view/half_onion_dome_container.dart';
import 'package:frontend/utils/constants.dart';

class TaskCountSection extends StatelessWidget {
  const TaskCountSection({required this.onDrawerOpen, super.key});

  final VoidCallback? onDrawerOpen;

  @override
  Widget build(BuildContext context) {
    return HalfOnionDomeContainer(
      height: 276,
      child: Column(
        children: [
          DTAAppBar(title: 'Dashboard', onDrawerOpen: onDrawerOpen),
          Text(
            '81/164',
            style: TextStyle(
              color: appColors.primaryDark,
              fontFamily: Constants.fontDMSerifDisplay,
              fontSize: 54,
              height: 1.5,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -8),
            child: Text(
              'Tasks Completed',
              style: TextStyle(
                color: appColors.primaryDark.withOpacity(0.8),
                fontFamily: Constants.fontDMSerifDisplay,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 6),
          FractionallySizedBox(
            widthFactor: 0.425,
            child: LinearProgressIndicator(
              value: 81 / 164,
              borderRadius: BorderRadius.circular(13.84),
              minHeight: 11,
              backgroundColor: appColors.primaryDark.withOpacity(0.5),
              color: appColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
