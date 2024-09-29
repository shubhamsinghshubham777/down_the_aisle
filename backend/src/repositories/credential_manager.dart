// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:math';

import 'package:core/models/auth/tokens.dart';
import 'package:crypto/crypto.dart';

import '../models/token_config.dart';
import '../utils/custom_errors.dart';

abstract class CredentialManager {
  String generateRandomSalt({int length = 16});

  String getHashedPassword({required String password, required String salt});

  Tokens generateJWT({
    required String email,
    bool generateRefreshToken = false,
    int accessTokenExpiryHours = 2,
    int refreshTokenExpiryDays = 30,
  });

  JWTPayload? verifyJWT(String token);
}

class CredentialManagerImpl implements CredentialManager {
  const CredentialManagerImpl(this.config);

  final TokenConfig config;

  @override
  String generateRandomSalt({int length = 16}) {
    final random = Random.secure();
    final salt = List<int>.generate(length, (_) => random.nextInt(256));
    return salt.join();
  }

  @override
  String getHashedPassword({required String password, required String salt}) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.bytes.join();
  }

  @override
  Tokens generateJWT({
    required String email,
    bool generateRefreshToken = false,
    int accessTokenExpiryHours = 2,
    int refreshTokenExpiryDays = 30,
  }) {
    final currentTimeMillis = DateTime.now().millisecondsSinceEpoch;

    final accessTokenExpiryMillis = accessTokenExpiryHours * 60 * 60 * 1000;
    final refreshTokenExpiryMillis =
        refreshTokenExpiryDays * 24 * 60 * 60 * 1000;

    final accessTokenExpiryDate = DateTime.fromMillisecondsSinceEpoch(
      currentTimeMillis + accessTokenExpiryMillis,
    );
    final refreshTokenExpiryDate = DateTime.fromMillisecondsSinceEpoch(
      currentTimeMillis + refreshTokenExpiryMillis,
    );

    final accessTokenPayload = {
      'aud': config.jwtAudience,
      'iss': config.jwtIssuer,
      'email': email,
      'tokenType': TokenType.access.name,
      'exp': accessTokenExpiryDate.millisecondsSinceEpoch ~/ 1000,
      'iat': currentTimeMillis ~/ 1000,
    };

    final accessToken = _generateToken(accessTokenPayload, config.jwtSecret);

    String? refreshToken;
    if (generateRefreshToken) {
      final refreshTokenPayload = {
        'aud': config.jwtAudience,
        'iss': config.jwtIssuer,
        'email': email,
        'tokenType': TokenType.refresh.name,
        'exp': refreshTokenExpiryDate.millisecondsSinceEpoch ~/ 1000,
        'iat': currentTimeMillis ~/ 1000,
      };
      refreshToken = _generateToken(refreshTokenPayload, config.jwtSecret);
    }

    return Tokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  JWTPayload? verifyJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw const JWTFormatException(cause: 'Invalid token format');
    }

    try {
      final header = jsonDecode(_base64UrlDecode(parts[0]));
      final payload = jsonDecode(_base64UrlDecode(parts[1]));

      // Verify algorithm
      if (header['alg'] != 'HS256') {
        throw JWTFormatException(
          cause: 'Unsupported algorithm: ${header['alg']}',
        );
      }

      // Verify signature
      final message = '${parts[0]}.${parts[1]}';
      final hmac = Hmac(sha256, utf8.encode(config.jwtSecret));
      final digest = hmac.convert(utf8.encode(message));
      final computedSignature = _base64UrlEncode(digest.bytes);

      if (computedSignature != parts[2]) {
        throw const JWTInvalidSignatureException(cause: 'Invalid signature');
      }

      // Verify expiration
      final expiration = DateTime.fromMillisecondsSinceEpoch(
        (payload['exp'] as int) * 1000,
      );
      if (DateTime.now().isAfter(expiration)) {
        throw const JWTExpiredException(cause: 'Token has expired');
      }

      // Verify audience
      if (payload['aud'] != config.jwtAudience) {
        throw const JWTInvalidClaimException(cause: 'Invalid audience');
      }

      // Verify issuer
      if (payload['iss'] != config.jwtIssuer) {
        throw const JWTInvalidClaimException(cause: 'Invalid issuer');
      }

      return JWTPayload(
        payload['email'] as String,
        TokenType.values.firstWhere(
          (type) => type.name == payload['tokenType'],
        ),
      );
    } catch (e) {
      if (e is JWTException) rethrow;
      throw JWTFormatException(cause: 'Failed to parse token: $e');
    }
  }

  String _base64UrlEncode(List<int> bytes) {
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  String _base64UrlDecode(String str) {
    var output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
      case 3:
        output += '=';
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }

  String _generateToken(Map<String, dynamic> payload, String secret) {
    final header = {'alg': 'HS256', 'typ': 'JWT'};

    final encodedHeader = _base64UrlEncode(utf8.encode(jsonEncode(header)));
    final encodedPayload = _base64UrlEncode(utf8.encode(jsonEncode(payload)));
    final message = '$encodedHeader.$encodedPayload';

    final hmac = Hmac(sha256, utf8.encode(secret));
    final digest = hmac.convert(utf8.encode(message));
    final signature = _base64UrlEncode(digest.bytes);

    return '$message.$signature';
  }
}

enum TokenType { access, refresh }

class JWTPayload {
  const JWTPayload(this.email, this.type);

  final String email;
  final TokenType type;
}
