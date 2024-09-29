import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/register_request.dart';
import 'package:dart_frog/dart_frog.dart';

import '../../src/repositories/credential_manager.dart';
import '../../src/repositories/user_repository.dart';
import '../../src/utils/extensions.dart';

Future<Response> onRequest(RequestContext context) async {
  return await context.onRequestMethod(
    post: () async {
      final registerRequest = RegisterRequest.fromJson(
        await context.request.bodyAsMap,
      );

      final userRepo = await context.read<Future<UserRepository>>();

      // Check if the user already exists
      final userOrNull = await userRepo.findUser(registerRequest.email);

      // If the user exists, throw an error
      if (userOrNull != null) {
        return Response(
          statusCode: HttpStatus.expectationFailed,
          body: 'A user with the provided credentials already exists! Please '
              'login instead.',
        );
      }

      // If the user doesn't exist, create it, and return a success message
      final credentialManager = context.read<CredentialManager>();
      final passwordSalt = credentialManager.generateRandomSalt();
      final hashedPassword = credentialManager.getHashedPassword(
        password: registerRequest.password,
        salt: passwordSalt,
      );

      final isInserted = await userRepo.upsertUser(
        DTAUser(
          firstName: registerRequest.firstName,
          email: registerRequest.email,
          gender: registerRequest.gender,
          hashedPassword: hashedPassword,
          passwordSalt: passwordSalt,
        ),
      );

      return Response(
        statusCode: isInserted ? HttpStatus.ok : HttpStatus.expectationFailed,
        body: isInserted
            ? 'User registered successfully!'
            : 'User was NOT registered!',
      );
    },
    orElse: () {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: 'This endpoint only supports POST requests!',
      );
    },
  );
}
