import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../src/models/token_config.dart';
import '../src/repositories/credential_manager.dart';
import '../src/repositories/user_repository.dart';
import '../src/utils/extensions.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(Middlewares.userRepository)
      .use(Middlewares.db)
      .use(Middlewares.credentialManager);
}

class Middlewares {
  Middlewares._();

  static final userRepository = provider<Future<UserRepository>>(
    (context) async => MongoUserRepository(
      mongoDb: await context.injectMongoDB(),
    ),
  );

  static final db = provider<Future<Db>>(
    (_) async {
      final db = await Db.create(
        Platform.environment['MONGO_CONNECTION_STRING']!,
      );
      await db.open();
      return db;
    },
  );

  static final credentialManager = provider<CredentialManager>(
    (_) => CredentialManagerImpl(
      TokenConfig(
        jwtSecret: Platform.environment['JWT_SECRET']!,
        jwtAudience: Platform.environment['JWT_AUDIENCE']!,
        jwtIssuer: Platform.environment['JWT_ISSUER']!,
      ),
    ),
  );
}
