import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/common/view/half_onion_dome_container.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/main/view/main_screen.dart';
import 'package:frontend/utils/constants.dart';

class SetupProfileSection extends StatelessWidget {
  const SetupProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return HalfOnionDomeContainer(
      width: context.width,
      height: 350,
      child: Stack(
        children: [
          Image.asset(
            Assets.imagesFloralBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFFFF7E7).withOpacity(0.8),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              top: MainScreen.appBarSize(context).height,
            ),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hello, Divya!',
                    style: context.displaySmall?.copyWith(
                      color: appColors.secondaryDark,
                      fontFamily: Constants.fontComforter,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Add a detailed profile to get personalised suggestions',
                    style: context.labelMedium?.copyWith(
                      color: appColors.secondaryDark.withOpacity(0.8),
                      fontFamily: Constants.fontKantumruy,
                      height: 1.5,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  DTAButton.filled(
                    text: 'Set up Profile',
                    padding: const EdgeInsets.only(
                      left: 21.84,
                      top: 9,
                      right: 26.16,
                      bottom: 9,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: -4,
            height: 233,
            child: Image.asset(Assets.imagesAvatarWoman),
          ),
        ],
      ),
    );
  }
}
