class MessageException implements Exception {
  const MessageException(this.message);
  final String message;
}

class JWTException implements Exception {
  const JWTException({this.cause});
  final String? cause;
}

class JWTFormatException implements JWTException {
  const JWTFormatException({this.cause});
  @override
  final String? cause;
}

class JWTExpiredException implements JWTException {
  const JWTExpiredException({this.cause});
  @override
  final String? cause;
}

class JWTInvalidSignatureException implements JWTException {
  const JWTInvalidSignatureException({this.cause});
  @override
  final String? cause;
}

class JWTInvalidClaimException implements JWTException {
  const JWTInvalidClaimException({this.cause});
  @override
  final String? cause;
}

class UserNotFoundException implements MessageException {
  const UserNotFoundException();

  @override
  String get message => 'User with the given credentails was not found!';
}
