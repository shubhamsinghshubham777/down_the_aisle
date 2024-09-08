import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesX on SharedPreferences {
  String? get accessToken => getString(_accessTokenKey);

  Future<void> setAccessToken(String token) {
    return setString(_accessTokenKey, token);
  }
}

const _accessTokenKey = 'access_token';
