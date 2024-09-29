import 'dart:convert';
import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/tokens.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/user/profile.dart' as route;
import '../../../src/models/token_config.dart';
import '../../../src/repositories/credential_manager.dart';
import '../../../src/repositories/user_repository.dart';
import '../../../src/utils/extensions.dart';
import '../../mocks.dart';

void main() {
  group('/user/profile', () {
    late RequestContext context;
    late UserRepository userRepository;
    late CredentialManager credentialManager;
    late Tokens tokens;

    setUp(() {
      context = MockRequestContext();
      userRepository = MockUserRepository();
      credentialManager = const CredentialManagerImpl(
        TokenConfig(
          jwtSecret: 'test_secret',
          jwtAudience: 'test_audience',
          jwtIssuer: 'test_issuer',
        ),
      );
      tokens = credentialManager.generateJWT(email: _fakeUser.email);
      when(() => context.injectUserRepository()).thenAnswer(
        (_) async => userRepository,
      );
      when(() => context.injectCredentialManager()).thenReturn(
        credentialManager,
      );
      when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
        (_) async => _fakeUser,
      );
    });

    test('responds with a 400 for unsupported request methods', () async {
      // Arrange
      when(() => context.request).thenReturn(
        Request.post(
          Uri.base,
          headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
          body: jsonEncode(_fakeUser),
        ),
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
      when(() => context.request).thenReturn(
        Request.get(
          Uri.base,
          headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
          body: jsonEncode(_fakeUser),
        ),
      );

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.ok);
    });

    test('responds with 200 if user was updated successfully', () async {
      // Arrange
      when(() => context.request).thenReturn(
        Request.patch(
          Uri.base,
          headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
          body: jsonEncode(_fakeUser),
        ),
      );
      when(() => userRepository.upsertUser(_fakeUser)).thenAnswer(
        (_) async => true,
      );

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.ok);
      expect(await response.body(), '');
    });

    test('responds with 417 if user was NOT updated', () async {
      // Arrange
      when(() => context.request).thenReturn(
        Request.patch(
          Uri.base,
          headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
          body: jsonEncode(_fakeUser),
        ),
      );
      when(() => userRepository.upsertUser(_fakeUser)).thenAnswer(
        (_) async => false,
      );

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.expectationFailed);
      expect(
        await response.body(),
        'Could not update user! Please check your input(s) or try again later.',
      );
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
