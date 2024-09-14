class JWTException implements Exception {
  JWTException(this.cause);
  String cause;
}

class JWTFormatException implements JWTException {
  JWTFormatException(this.cause);
  @override
  String cause;
}

class JWTExpiredException implements JWTException {
  JWTExpiredException(this.cause);
  @override
  String cause;
}

class JWTInvalidSignatureException implements JWTException {
  JWTInvalidSignatureException(this.cause);
  @override
  String cause;
}

class JWTInvalidClaimException implements JWTException {
  JWTInvalidClaimException(this.cause);
  @override
  String cause;
}
