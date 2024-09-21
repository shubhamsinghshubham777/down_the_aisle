import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';

class CustomPackageAdvertisement extends StatelessWidget {
  const CustomPackageAdvertisement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
      decoration: BoxDecoration(
        color: appColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you tired?',
                      style: context.titleLarge?.copyWith(
                        fontFamily: Constants.fontDMSerifDisplay,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Tired of looking through every single vendor of each service type? We will select a tailored package that best fits your interests.',
                        style: context.labelSmall?.copyWith(
                          fontFamily: Constants.fontKantumruy,
                          height: 1.5,
                        ),
                      ),
                    ),
                    DTAButton.filled(
                      text: 'Custom Package',
                      padding: const EdgeInsets.only(
                        left: 23,
                        top: 9,
                        right: 25,
                        bottom: 9,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: const Offset(0, -16),
              child: SvgPicture.asset(Assets.iconsDecoration),
            ),
          ),
        ],
      ),
    );
  }
}
