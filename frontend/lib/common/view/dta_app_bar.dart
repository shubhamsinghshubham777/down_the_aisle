import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';

class DTAAppBar extends StatelessWidget {
  const DTAAppBar({
    required this.title,
    super.key,
    this.onDrawerOpen,
  });

  final String title;
  final VoidCallback? onDrawerOpen;

  static Size appBarSize(BuildContext context) => Size(
        context.width,
        // AppBar (content + padding) height
        36 + _appBarPadding(context).vertical,
      );

  static EdgeInsets _appBarPadding(BuildContext context) {
    return EdgeInsets.only(
      left: 20,
      top: 24 + context.mqViewPadding.top,
      right: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: DTAAppBar.appBarSize(context),
      child: Padding(
        padding: DTAAppBar._appBarPadding(context),
        child: Stack(
          children: [
            Align(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: Constants.fontDMSerifDisplay,
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ZoomTapDetector(
                onTap: onDrawerOpen,
                child: Container(
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        blurRadius: 20,
                        color: appColors.accent.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      top: 5,
                      right: 4,
                      bottom: 3,
                    ),
                    child: SvgPicture.asset(Assets.iconBxMenu),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ZoomTapDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      Assets.iconBiBell,
                      width: 24,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ZoomTapDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      Assets.iconOcticonPerson,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
