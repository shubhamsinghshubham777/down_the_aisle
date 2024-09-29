import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:dart_frog/dart_frog.dart';

import '../../src/utils/extensions.dart';
import '../../src/utils/utils.dart';

Future<Response> onRequest(RequestContext context) {
  return protected(
    context,
    body: (userFromJWT) async {
      return await context.onRequestMethod(
        get: () async {
          return Response.json(
            body: userFromJWT?.copyWith(
              hashedPassword: null,
              passwordSalt: null,
            ),
          );
        },
        patch: () async {
          final userRepo = await context.injectUserRepository();
          final rawUser = await context.request.bodyAsMap;
          final user = DTAUser.fromJson(rawUser);
          final success = await userRepo.upsertUser(user);
          return Response(
            statusCode: success ? HttpStatus.ok : HttpStatus.expectationFailed,
            body: success
                ? null
                : 'Could not update user! Please check your input(s) or try '
                    'again later.',
          );
        },
        orElse: () => Response(
          statusCode: HttpStatus.badRequest,
          body: 'This endpoint only supports GET and PATCH requests!',
        ),
      );
    },
    onError: (e, st) {
      return Response(
        statusCode: HttpStatus.internalServerError,
        body: 'The server is facing some issues in addressing your request at '
            'the moment. Please try again later.',
      );
    },
  );
}
