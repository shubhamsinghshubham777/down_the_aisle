import 'package:animations/animations.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_button.dart';
import 'package:frontend/common/view/greeting_bg_clipper.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/auth/view/sign_up_dialog.dart';
import 'package:frontend/utils/constants.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Pink background (useful for cover-up when screen resolution is
          // bigger than image resolution)
          SizedBox.expand(child: ColoredBox(color: appColors.backgroundPink)),

          // Pink background image
          SizedBox.expand(
            child: Image.asset(Assets.imagesAuthBg, fit: BoxFit.fitHeight),
          ),

          // Golden border
          ClipPath(
            clipper: GreetingBGShape(),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesAuthBgBorder),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: const BoxConstraints(
                maxWidth: 375,
                maxHeight: 812,
              ),
              width: context.width * 0.9,
              height: context.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(10),
                // White container
                child: ClipPath(
                  clipper: GreetingBGShape(),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    color: appColors.primaryLight,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 180),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              child: Text(
                                'Down the Aisle',
                                style: TextStyle(
                                  color: appColors.primaryDark,
                                  fontSize: 40,
                                  fontFamily: Constants.fontDMSerifDisplay,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(height: 19),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Have the wedding of your dreams '
                                'without giving up on your dreams.'
                                '\n\nAll your wedding planning needs '
                                'in one place.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: Constants.fontKrylon,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 5,
                              ),
                            ),
                            const SizedBox(height: 19),
                            DTAButton.filled(
                              text: 'Sign Up',
                              onTap: () => showModal(
                                context: context,
                                builder: (_) => const SignUpDialog(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const DTAButton.outlined(text: 'Login'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -92,
            child: SizedBox(
              width: 600,
              height: 310,
              child: Image.asset(
                Assets.imagesFlowers,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
