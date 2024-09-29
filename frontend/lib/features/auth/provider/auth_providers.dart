import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/login_request.dart';
import 'package:core/models/auth/register_request.dart';
import 'package:frontend/common/providers.dart';
import 'package:frontend/features/auth/data/auth_service.dart';
import 'package:frontend/features/home/data/user_service.dart';
import 'package:frontend/features/home/provider/setup_profile_dialog_providers.dart';
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
  UserService get _userService => ref.read(userServiceProvider);
  Future<SharedPreferences> get _sharedPrefs =>
      ref.read(sharedPreferencesProvider.future);

  @override
  FutureOr<DTAUser?> build() async {
    try {
      final response = await _userService.getUserProfile();
      if (response.hasError) throw Exception(response.errorMessage);
      return response.data;
    } catch (e, st) {
      debugLog(e, stackTrace: st, tag: _tag);
      return null;
    }
  }

  Future<void> loginUser(LoginRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await _authService.loginUser(request);
      if (response.hasError) throw Exception(response.errorMessage);
      final tokens = response.data;
      final prefs = await _sharedPrefs;
      await Future.wait([
        prefs.setAccessToken(tokens.accessToken),
        prefs.setRefreshToken(tokens.refreshToken),
      ]);
      final profileResponse = await _userService.getUserProfile();
      if (profileResponse.hasError) {
        throw Exception(profileResponse.errorMessage);
      }
      return profileResponse.data;
    });
  }

  Future<void> registerUser(RegisterRequest request) async {
    state = const AsyncLoading();
    try {
      final response = await _authService.registerUser(request);
      if (response.hasError) {
        state = AsyncError(
          Exception(response.errorMessage),
          StackTrace.current,
        );
      }
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(
        e.dioHandledError,
        StackTrace.current,
      );
    }
  }

  Future<void> logout() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.deleteAccessToken();
    ref.invalidateSelf();
  }
}

const _tag = 'auth_providers';
