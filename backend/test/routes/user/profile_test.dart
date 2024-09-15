import 'dart:convert';
import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/user/profile.dart' as route;
import '../../../src/models/token_config.dart';
import '../../../src/repositories/credential_manager.dart';
import '../../../src/repositories/user_repository.dart';
import '../../mocks.dart';

void main() {
  group('GET /user/profile', () {
    late RequestContext context;
    late UserRepository userRepository;

    setUp(() {
      context = MockRequestContext();
      userRepository = MockUserRepository();
    });

    test('responds with a 400 for non-GET requests', () async {
      // Arrange
      when(() => context.request).thenReturn(
        Request.post(Uri.base, body: jsonEncode(_fakeUser)),
      );

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.badRequest);
    });

    test('responds with a 401 for invalid token', () async {
      // Arrange
      when(() => context.request).thenReturn(
        Request.get(Uri.base, body: jsonEncode(_fakeUser)),
      );

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.unauthorized);
    });

    test('responds with a 200 for a valid token', () async {
      // Arrange
      const credentialManager = CredentialManagerImpl(
        TokenConfig(
          jwtSecret: 'test_secret',
          jwtAudience: 'test_audience',
          jwtIssuer: 'test_issuer',
        ),
      );

      final tokens = credentialManager.generateJWT(email: _fakeUser.email);

      when(() => context.request).thenReturn(
        Request.get(
          Uri.base,
          headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
          body: jsonEncode(_fakeUser),
        ),
      );

      when(() => context.read<Future<UserRepository>>()).thenAnswer(
        (_) async => userRepository,
      );

      when(() => context.read<CredentialManager>()).thenReturn(
        credentialManager,
      );

      when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
        (_) async => _fakeUser,
      );

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.ok);
    });
  });
}

const _fakeUser = DTAUser(
  firstName: 'test_name',
  email: 'test@email.com',
  gender: Gender.male,
  hashedPassword: 'test_hashed_password',
  passwordSalt: 'test_salt',
);
