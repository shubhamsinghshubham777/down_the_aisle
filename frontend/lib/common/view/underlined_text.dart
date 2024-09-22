import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/utils/constants.dart';

class UnderlinedText extends StatelessWidget {
  const UnderlinedText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: appColors.accent,
        fontFamily: Constants.fontKantumruy,
        fontSize: 13,
        decoration: TextDecoration.underline,
        decorationColor: appColors.accent,
      ),
    );
  }
}
