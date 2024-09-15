import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/login_request.dart';
import 'package:core/models/auth/register_request.dart';
import 'package:frontend/common/providers.dart';
import 'package:frontend/features/auth/data/auth_service.dart';
import 'package:frontend/utils/extensions.dart';
import 'package:frontend/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_providers.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref.watch(dioProvider));
}

@riverpod
class Authentication extends _$Authentication {
  AuthService get _authService => ref.read(authServiceProvider);
  Future<SharedPreferences> get _sharedPrefs =>
      ref.read(sharedPreferencesProvider.future);

  @override
  FutureOr<DTAUser?> build() async {
    try {
      return await _authService.getUserProfile();
    } catch (e, st) {
      debugLog(e, stackTrace: st, tag: _tag);
      return null;
    }
  }

  Future<void> loginUser(LoginRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final tokens = await _authService.loginUser(request);
      final prefs = await _sharedPrefs;
      await Future.wait([
        prefs.setAccessToken(tokens.accessToken),
        prefs.setRefreshToken(tokens.refreshToken),
      ]);
      return _authService.getUserProfile();
    });
  }

  Future<void> registerUser(RegisterRequest request) async {
    state = const AsyncLoading();
    await _authService.registerUser(request);
    state = const AsyncData(null);
  }
}

const _tag = 'auth_providers';
