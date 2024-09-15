import 'package:core/models/auth/dta_user.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../repositories/credential_manager.dart';
import '../repositories/user_repository.dart';

extension RequestX on Request {
  Future<Map<String, dynamic>> get bodyAsMap async {
    return await json() as Map<String, dynamic>;
  }
}

extension MongoDbExtensions on Db {
  DbCollection get usersCollection => collection('users');
}

extension RequestContextX on RequestContext {
  bool get isGetRequest => request.method == HttpMethod.get;
  bool get isPostRequest => request.method == HttpMethod.post;
  bool get isPatchRequest => request.method == HttpMethod.patch;
  bool get isDeleteRequest => request.method == HttpMethod.delete;

  Future<DTAUser?> get userFromJWT async {
    final token = request.headers.bearer();
    if (token != null) {
      final userRepo = await read<Future<UserRepository>>();
      final credentialManager = read<CredentialManager>();
      final payload = credentialManager.verifyJWT(token);
      if (payload != null && payload.type == TokenType.access) {
        return userRepo.findUser(payload.email);
      }
    }
    return null;
  }
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
