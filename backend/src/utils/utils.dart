import 'dart:io';

import 'package:core/models/auth/dta_user.dart';
import 'package:dart_frog/dart_frog.dart';

import 'custom_errors.dart';
import 'extensions.dart';
import 'global_instances.dart';

Future<Response> protected(
  RequestContext context, {
  required Future<Response> Function(DTAUser? user) body,
  required Response Function(dynamic e, StackTrace stackTrace) onError,
}) async {
  try {
    return body(await context.userFromJWT);
  } catch (e, st) {
    logger.e(e, stackTrace: st);
    if (e is JWTException) {
      return Response(
        statusCode: HttpStatus.unauthorized,
        body: 'Your access token is either invalid or expired! Please make '
            'sure to use a valid token.',
      );
    } else {
      return onError(e, st);
    }
  }
}
