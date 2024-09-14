// ignore_for_file: avoid_print, avoid_redundant_argument_values

import 'package:test/test.dart';

import '../../../src/models/token_config.dart';
import '../../../src/repositories/credential_manager.dart';
import '../../../src/utils/custom_errors.dart';

void main() {
  group('JWT verifier tests', () {
    late CredentialManager credentialManager;

    setUp(() {
      credentialManager = const CredentialManagerImpl(_testTokenConfig);
    });

    test('Valid token config produces a valid JWT ', () {
      var didTestPass = false;
      try {
        final tokens = credentialManager.generateJWT(
          email: 'user@example.com',
          generateRefreshToken: true,
          accessTokenExpiryHours: 1,
          refreshTokenExpiryDays: 7,
        );
        credentialManager.verifyJWT(tokens.accessToken);
        print('Positive case passed');
        didTestPass = true;
      } catch (e) {
        print('Positive case failed: $e');
        didTestPass = false;
      }
      expect(didTestPass, true);
    });

    test('Throws exception for expired JWT', () {
      var didTestPass = false;
      try {
        final tokens = credentialManager.generateJWT(
          email: 'user@example.com',
          generateRefreshToken: false,
          accessTokenExpiryHours: -1, // Expired 1 hour ago
          refreshTokenExpiryDays: 7,
        );
        credentialManager.verifyJWT(tokens.accessToken);
        print('Expired token case failed: No exception thrown');
        didTestPass = false;
      } catch (e) {
        if (e is JWTExpiredException) {
          print('Expired token case passed: ${e.cause}');
          didTestPass = true;
        } else {
          print('Expired token case failed: Unexpected exception $e');
          didTestPass = false;
        }
      }
      expect(didTestPass, true);
    });

    test('Throws exception for invalid signature', () {
      var didTestPass = false;
      try {
        final tokens = credentialManager.generateJWT(
          email: 'user@example.com',
          generateRefreshToken: false,
          accessTokenExpiryHours: 1,
          refreshTokenExpiryDays: 7,
        );
        final parts = tokens.accessToken.split('.');
        final tamperedToken = '${parts[0]}.${parts[1]}.invalidSignature';
        credentialManager.verifyJWT(tamperedToken);
        print('Invalid signature case failed: No exception thrown');
        didTestPass = false;
      } catch (e) {
        if (e is JWTInvalidSignatureException) {
          print('Invalid signature case passed: ${e.cause}');
          didTestPass = true;
        } else {
          print('Invalid signature case failed: Unexpected exception $e');
          didTestPass = false;
        }
      }
      expect(didTestPass, true);
    });

    test('Throws exception for invalid format', () {
      var didTestPass = false;
      try {
        credentialManager.verifyJWT('invalid.token');
        print('Invalid format case failed: No exception thrown');
        didTestPass = false;
      } catch (e) {
        if (e is JWTFormatException) {
          print('Invalid format case passed: ${e.cause}');
          didTestPass = true;
        } else {
          print('Invalid format case failed: Unexpected exception $e');
          didTestPass = false;
        }
      }
      expect(didTestPass, true);
    });

    test('Throws exception for invalid audience', () {
      var didTestPass = false;
      try {
        final invalidAudienceConfig = TokenConfig(
          jwtSecret: _testTokenConfig.jwtSecret,
          jwtAudience: 'invalid-audience',
          jwtIssuer: _testTokenConfig.jwtIssuer,
        );
        final invalidAudienceCredentialManager = CredentialManagerImpl(
          invalidAudienceConfig,
        );
        final tokens = invalidAudienceCredentialManager.generateJWT(
          email: 'user@example.com',
          generateRefreshToken: false,
          accessTokenExpiryHours: 1,
          refreshTokenExpiryDays: 7,
        );
        credentialManager.verifyJWT(tokens.accessToken);
        print('Invalid audience case failed: No exception thrown');
        didTestPass = false;
      } catch (e) {
        if (e is JWTInvalidClaimException) {
          print('Invalid audience case passed: ${e.cause}');
          didTestPass = true;
        } else {
          print('Invalid audience case failed: Unexpected exception $e');
          didTestPass = false;
        }
      }
      expect(didTestPass, true);
    });
  });
}

const _testTokenConfig = TokenConfig(
  jwtSecret: 'test-secret-key',
  jwtAudience: 'test-audience',
  jwtIssuer: 'test-issuer',
);
