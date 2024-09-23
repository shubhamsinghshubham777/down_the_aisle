import 'package:core/models/auth/dta_user.dart';
import 'package:frontend/features/auth/provider/auth_providers.dart';
import 'package:frontend/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen_provider.g.dart';

@riverpod
FutureOr<DTAUser> userProfile(UserProfileRef ref) async {
  final authService = ref.watch(authServiceProvider);
  final response = await authService.getUserProfile();
  if (response.hasError) throw Exception(response.errorMessage);
  return response.data;
}
