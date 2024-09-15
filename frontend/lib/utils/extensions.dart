import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension BuildContextX on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: bodyMedium?.copyWith(color: appColors.secondaryDark),
          ),
          backgroundColor: appColors.surface,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }
}

extension SharedPreferencesX on SharedPreferences {
  String? get accessToken => getString(_accessTokenKey);

  Future<void> setAccessToken(String token) {
    return setString(_accessTokenKey, token);
  }

  String? get refreshToken => getString(_refreshTokenKey);

  Future<void> setRefreshToken(String? token) async {
    if (token != null) {
      await setString(_refreshTokenKey, token);
    }
  }
}

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';
