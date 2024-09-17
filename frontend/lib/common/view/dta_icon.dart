import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';

class DtaIcon extends StatelessWidget {
  const DtaIcon(
    this.asset, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.onTap,
  });

  final String asset;
  final Color? color;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(
          color ?? appColors.surface,
          BlendMode.srcIn,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
