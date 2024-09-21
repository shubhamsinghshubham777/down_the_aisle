import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension DateTimeX on DateTime {
  String get monthName => switch (month) {
        DateTime.january => 'Jan',
        DateTime.february => 'Feb',
        DateTime.march => 'Mar',
        DateTime.april => 'Apr',
        DateTime.may => 'May',
        DateTime.june => 'Jun',
        DateTime.july => 'Jul',
        DateTime.august => 'Aug',
        DateTime.september => 'Sep',
        DateTime.october => 'Oct',
        DateTime.november => 'Nov',
        _ => 'Dec',
      };

  String get dayName => switch (weekday) {
        DateTime.sunday => 'Sunday',
        DateTime.monday => 'Monday',
        DateTime.tuesday => 'Tuesday',
        DateTime.wednesday => 'Wednesday',
        DateTime.thursday => 'Thursday',
        DateTime.friday => 'Friday',
        _ => 'Saturday',
      };
}

extension ObjectX on Object {
  Object get dioHandledError => this is DioException
      ? (this as DioException).response?.errorMessage ?? 'Unexpected error!'
      : this;
}

extension HttpResponseX<T> on HttpResponse<T> {
  bool get hasError => response.hasError;
  String? get errorMessage => response.errorMessage;
}

extension ResponseX<T> on Response<T> {
  bool get hasError => (statusCode ?? 0) >= 400;
  String? get errorMessage => data as String?;
}

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
