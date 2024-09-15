import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../src/utils/custom_errors.dart';
import '../../src/utils/extensions.dart';

Future<Response> onRequest(RequestContext context) async {
  if (!context.isGetRequest) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'This endpoint only supports GET requests!',
    );
  }

  try {
    final user = await context.userFromJWT;
    if (user == null) throw JWTException('Invalid token!');

    return Response.json(
      body: user.copyWith(
        hashedPassword: null,
        passwordSalt: null,
      ),
    );
  } catch (e) {
    if (e is JWTException) {
      return Response(
        statusCode: HttpStatus.unauthorized,
        body: 'Your access token is either invalid or expired! Please make '
            'sure to use a valid token.',
      );
    }
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: 'The server is facing some issues in addressing your request at '
          'the moment. Please try again later.',
    );
  }
}
