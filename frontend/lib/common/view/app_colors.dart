import 'package:flutter/material.dart';

class AppColors {
  const AppColors._({
    required this.accent,
    required this.primaryDark,
    required this.primaryMedium,
    required this.primaryLight,
    required this.surface,
    required this.secondaryLight,
    required this.secondaryMedium,
    required this.secondaryDark,
    required this.backgroundPink,
  });

  final Color accent;
  final Color primaryDark;
  final Color primaryMedium;
  final Color primaryLight;
  final Color surface;
  final Color secondaryLight;
  final Color secondaryMedium;
  final Color secondaryDark;
  final Color backgroundPink;
}

const appColors = AppColors._(
  accent: Color(0xFF9A2143),
  primaryDark: Color(0xFFBFA054),
  primaryMedium: Color(0xFFEDD498),
  primaryLight: Color(0xFFFBF8F2),
  surface: Color(0xFFFFFFFF),
  secondaryLight: Color(0xFFF6F6F6),
  secondaryMedium: Color(0xFF9EA1AB),
  secondaryDark: Color(0xFF1E2742),
  backgroundPink: Color(0xFFFDAD9B),
);
