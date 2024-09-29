import 'package:freezed_annotation/freezed_annotation.dart';

part 'dta_user.freezed.dart';
part 'dta_user.g.dart';

@freezed
class DTAUser with _$DTAUser {
  const factory DTAUser({
    required String firstName,
    required String email,
    required Gender gender,
    String? hashedPassword,
    String? passwordSalt,
    int? weddingBudget,
    String? weddingDate,
  }) = _DTAUser;

  factory DTAUser.fromJson(Map<String, Object?> json) =>
      _$DTAUserFromJson(json);
}

enum Gender { male, female, other }
