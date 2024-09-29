import 'dart:convert';
import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/register_request.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/auth/register.dart' as route;
import '../../../src/repositories/credential_manager.dart';
import '../../../src/repositories/user_repository.dart';
import '../../mocks.dart';

void main() {
  group('POST /auth/register tests', () {
    late RequestContext context;
    late RegisterRequest registerRequest;
    late UserRepository userRepository;
    late CredentialManager credentialManager;

    setUp(() {
      context = MockRequestContext();

      registerRequest = RegisterRequest(
        firstName: _fakeUser.firstName,
        email: _fakeUser.email,
        gender: _fakeUser.gender,
        password: 'test_password',
      );

      userRepository = MockUserRepository();
      credentialManager = MockCredentialManager();

      when(() => context.request).thenReturn(
        Request.post(
          Uri.base,
          body: jsonEncode(registerRequest),
        ),
      );

      when(() => context.read<Future<UserRepository>>()).thenAnswer(
        (_) async => userRepository,
      );

      when(() => context.read<CredentialManager>()).thenReturn(
        credentialManager,
      );

      when(credentialManager.generateRandomSalt).thenReturn(
        _fakeUser.passwordSalt!,
      );

      when(
        () => credentialManager.getHashedPassword(
          password: registerRequest.password,
          salt: _fakeUser.passwordSalt!,
        ),
      ).thenReturn(_fakeUser.hashedPassword!);
    });

    test('responds with 400 for non-POST requests', () async {
      when(() => context.request).thenReturn(
        Request.get(
          Uri.base,
          body: jsonEncode(registerRequest),
        ),
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, HttpStatus.badRequest);
    });

    test('responds with 417 if the user already exists', () async {
      when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
        (_) async => _fakeUser,
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, HttpStatus.expectationFailed);
    });

    test(
      'responds with 417 if the registration fails for any reason',
      () async {
        when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
          (_) async => null,
        );

        when(() => userRepository.upsertUser(_fakeUser)).thenAnswer(
          (_) async => false,
        );

        final response = await route.onRequest(context);
        expect(response.statusCode, HttpStatus.expectationFailed);
      },
    );

    test('responds with 200 for valid credentials', () async {
      when(() => userRepository.findUser(_fakeUser.email)).thenAnswer(
        (_) async => null,
      );

      when(() => userRepository.upsertUser(_fakeUser)).thenAnswer(
        (_) async => true,
      );

      final response = await route.onRequest(context);
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
