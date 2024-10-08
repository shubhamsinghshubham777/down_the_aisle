import 'package:animations/animations.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:core/models/auth/dta_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_app_bar.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/common/view/half_onion_dome_container.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/auth/provider/auth_providers.dart';
import 'package:frontend/features/home/view/setup_profile_dialog.dart';
import 'package:frontend/utils/constants.dart';

class SetupProfileSection extends ConsumerWidget {
  const SetupProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileState = ref.watch(authenticationProvider);
    final userGender = userProfileState.valueOrNull?.gender;

    return HalfOnionDomeContainer(
      width: context.width,
      height: 350 + context.mqViewPadding.top,
      child: Stack(
        children: [
          Image.asset(
            Assets.imageFloralBg,
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
              top: DTAAppBar.appBarSize(context).height + 24,
            ),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userProfileState.maybeWhen(
                      data: (user) =>
                          'Hello${user != null ? ', ${user.firstName}' : ''}!',
                      loading: () => 'Loading...',
                      orElse: () => '',
                    ),
                    style: context.displaySmall?.copyWith(
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
                    onTap: () => showModal<void>(
                      context: context,
                      builder: (_) => const SetupProfileDialog(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (userGender != null)
            Positioned(
              bottom: 20,
              right: userGender == Gender.female ? -4 : 0,
              child: Image.asset(
                switch (userGender) {
                  Gender.male => Assets.imageAvatarMan,
                  Gender.female => Assets.imageAvatarWoman,
                  Gender.other => Assets.imageAvatarOther,
                },
                height: userGender == Gender.female ? 233 : 270,
              ),
            ),
        ],
      ),
    );
  }
}
