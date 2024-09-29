import 'package:core/models/auth/dta_user.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../repositories/credential_manager.dart';
import '../repositories/user_repository.dart';
import 'custom_errors.dart';

extension RequestX on Request {
  Future<Map<String, dynamic>> get bodyAsMap async {
    return await json() as Map<String, dynamic>;
  }
}

extension MongoDbExtensions on Db {
  DbCollection get usersCollection => collection('users');
}

extension RequestContextX on RequestContext {
  T onRequestMethod<T>({
    required T Function() orElse,
    T Function()? get,
    T Function()? post,
    T Function()? patch,
    T Function()? delete,
  }) {
    final method = switch (request.method) {
      HttpMethod.get => get?.call,
      HttpMethod.post => post?.call,
      HttpMethod.patch => patch?.call,
      HttpMethod.delete => delete?.call,
      _ => orElse.call,
    };
    return (method ?? orElse.call).call();
  }

  Future<DTAUser?> get userFromJWT async {
    final token = request.headers.bearer();
    if (token != null) {
      final userRepo = await injectUserRepository();
      final credentialManager = injectCredentialManager();
      final payload = credentialManager.verifyJWT(token);
      if (payload != null && payload.type == TokenType.access) {
        return userRepo.findUser(payload.email);
      }
    }
    throw const JWTException();
  }

  Future<UserRepository> injectUserRepository() => read();
  CredentialManager injectCredentialManager() => read();
  Future<Db> injectMongoDB() => read();
}

extension on Map<String, String> {
  String? authorization(String type) {
    final value = this['Authorization']?.split(' ');

    if (value != null && value.length == 2 && value.first == type) {
      return value.last;
    }

    return null;
  }

  String? bearer() => authorization('Bearer');
}
