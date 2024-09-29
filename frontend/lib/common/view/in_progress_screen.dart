import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/main/view/main_screen.dart';
import 'package:frontend/utils/constants.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset(Assets.imageInProgress),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '🚧\nThis feature is a work-in-progress',
              style: TextStyle(
                color: appColors.secondaryDark,
                fontFamily: Constants.fontDMSerifDisplay,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: MainScreen.bottomNavBarHeight(context)),
        ],
      ),
    );
  }
}
