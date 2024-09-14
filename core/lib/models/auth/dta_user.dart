import 'package:freezed_annotation/freezed_annotation.dart';

part 'dta_user.freezed.dart';
part 'dta_user.g.dart';

@freezed
class DTAUser with _$DTAUser {
  const factory DTAUser({
    required String firstName,
    required String email,
    required String hashedPassword,
    required String passwordSalt,
    String? imageUrl,
  }) = _DTAUser;

  factory DTAUser.fromJson(Map<String, Object?> json) =>
      _$DTAUserFromJson(json);
}
