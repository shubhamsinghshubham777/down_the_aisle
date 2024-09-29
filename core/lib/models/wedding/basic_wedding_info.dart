import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_wedding_info.freezed.dart';
part 'basic_wedding_info.g.dart';

@freezed
class BasicWeddingInfo with _$BasicWeddingInfo {
  const factory BasicWeddingInfo({
    required int? budgetInRupees,
    required DateTime? date,
  }) = User_Profile;

  factory BasicWeddingInfo.fromJson(Map<String, Object?> json) =>
      _$BasicWeddingInfoFromJson(json);
}
