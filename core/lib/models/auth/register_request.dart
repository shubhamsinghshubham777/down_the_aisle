import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String firstName,
    required String email,
    required String password,
    @Uint8ListConverter() Uint8List? imageBytes,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, Object?> json) =>
      _$RegisterRequestFromJson(json);
}

class Uint8ListConverter extends JsonConverter<Uint8List, String> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(String json) {
    return Uint8List.fromList(
      json.split(',').map(int.parse).toList(),
    );
  }

  @override
  String toJson(Uint8List object) {
    return object.join(',');
  }
}
