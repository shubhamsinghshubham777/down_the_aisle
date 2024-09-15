import 'dart:io';

import 'package:core/models/auth/login_request.dart';
import 'package:dart_frog/dart_frog.dart';

import '../../src/repositories/credential_manager.dart';
import '../../src/repositories/user_repository.dart';
import '../../src/utils/extensions.dart';
import '../../src/utils/global_instances.dart';

Future<Response> onRequest(RequestContext context) async {
  if (!context.isPostRequest) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'This endpoint only supports POST requests!',
    );
  }

  final loginRequest = LoginRequest.fromJson(
    await context.request.bodyAsMap,
  );

  final userRepository = await context.read<Future<UserRepository>>();

  // Check if a user with the provided e-mail exists
  final user = await userRepository.findUser(loginRequest.email);

  // If user doesn't exist, return an error response
  if (user == null) {
    logger.e('User for e-mail (${loginRequest.email}) does not exist!');
    return Response(
      statusCode: HttpStatus.expectationFailed,
      body: _loginErrorMessage,
    );
  }

  // If user exists, generate its hashed password and compare with the one in DB
  final credentialManager = context.read<CredentialManager>();
  final hashedPassword = credentialManager.getHashedPassword(
    password: loginRequest.password,
    salt: user.passwordSalt!,
  );

  // If hashed passwords do not match, return an error response
  if (hashedPassword != user.hashedPassword) {
    logger.e('Password for user (${loginRequest.email}) is invalid!');
    return Response(
      statusCode: HttpStatus.expectationFailed,
      body: _loginErrorMessage,
    );
  }

  // If hashed passwords match, generate & return user access & refresh tokens
  final tokens = credentialManager.generateJWT(
    email: loginRequest.email,
    generateRefreshToken: true,
  );

  return Response.json(body: tokens.toJson());
}

// The error message is deliberately a vague one to ensure that a bad
// entity is not able to differentiate between the credentials not existing
// or just being incorrect.
const _loginErrorMessage = 'Incorrect credentials! Please try again.';
