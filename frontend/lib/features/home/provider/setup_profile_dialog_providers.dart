import 'package:core/models/auth/dta_user.dart';
import 'package:frontend/common/providers.dart';
import 'package:frontend/features/auth/provider/auth_providers.dart';
import 'package:frontend/features/home/data/user_service.dart';
import 'package:frontend/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setup_profile_dialog_providers.g.dart';

@riverpod
UserService userService(UserServiceRef ref) {
  return UserService(ref.watch(dioProvider));
}

@riverpod
class SetupProfileDialogState extends _$SetupProfileDialogState {
  UserService get _userService => ref.read(userServiceProvider);

  @override
  DTAUser? build() => ref.watch(authenticationProvider).valueOrNull;

  Future<void> updateState({
    int? weddingBudget,
    String? weddingDate,
  }) async {
    try {
      if (state != null) {
        await _userService.updateUserProfile(
          state!.copyWith(
            weddingBudget: weddingBudget,
            weddingDate: weddingDate,
          ),
        );
        ref.invalidate(authenticationProvider);
      }
    } catch (e, st) {
      debugLog(e, stackTrace: st);
    }
  }
}
