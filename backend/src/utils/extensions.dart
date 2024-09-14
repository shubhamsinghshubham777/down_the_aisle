import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

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
}
