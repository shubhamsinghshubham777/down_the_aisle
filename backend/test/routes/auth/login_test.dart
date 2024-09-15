import 'dart:convert';
import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/login_request.dart';
import 'package:core/models/auth/tokens.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/auth/login.dart' as route;
import '../../../src/repositories/credential_manager.dart';
import '../../../src/repositories/user_repository.dart';
import '../../mocks.dart';

void main() {
  group('POST /auth/login tests', () {
    late RequestContext context;
    late LoginRequest loginRequest;
    late UserRepository userRepository;

    setUp(() {
      context = MockRequestContext();

      loginRequest = LoginRequest(
        email: _fakeUser.email,
        password: 'test_password',
      );

      userRepository = MockUserRepository();

      when(() => context.request).thenReturn(
        Request.post(
          Uri.base,
          body: jsonEncode(loginRequest),
        ),
      );
    });

    test('responds with a 200 for valid credentials', () async {
      final credentialManager = MockCredentialManager();

      when(() => context.read<Future<UserRepository>>()).thenAnswer(
        (_) async => userRepository,
      );

      when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
        (_) async => _fakeUser,
      );

      when(() => context.read<CredentialManager>()).thenReturn(
        credentialManager,
      );

      when(
        () => credentialManager.getHashedPassword(
          password: loginRequest.password,
          salt: _fakeUser.passwordSalt!,
        ),
      ).thenReturn(_fakeUser.hashedPassword!);

      when(
        () => credentialManager.generateJWT(
          email: _fakeUser.email,
          generateRefreshToken: true,
        ),
      ).thenReturn(
        const Tokens(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        ),
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, HttpStatus.ok);
    });

    test('responds with a 417 for invalid credentials', () async {
      when(() => context.read<Future<UserRepository>>()).thenAnswer(
        (_) async => userRepository,
      );

      when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
        (_) async => null,
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, HttpStatus.expectationFailed);
    });

    test('responds with a 400 for non-POST requests', () async {
      when(() => context.request).thenReturn(
        Request.get(Uri.base, body: jsonEncode(loginRequest)),
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, HttpStatus.badRequest);
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
