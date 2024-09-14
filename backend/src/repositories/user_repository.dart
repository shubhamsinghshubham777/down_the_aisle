import 'package:core/models/auth/dta_user.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../utils/extensions.dart';

abstract class UserRepository {
  Future<DTAUser?> findUser(String email);
  Future<bool> insertUser(DTAUser user);
}

class MongoUserRepository implements UserRepository {
  const MongoUserRepository({required this.mongoDb});

  final Db mongoDb;

  @override
  Future<DTAUser?> findUser(String email) async {
    final rawUserOrNull = await mongoDb.usersCollection.findOne(
      where.eq('email', email),
    );
    if (rawUserOrNull != null) {
      return DTAUser.fromJson(rawUserOrNull);
    } else {
      return null;
    }
  }

  @override
  Future<bool> insertUser(DTAUser user) async {
    final result = await mongoDb.usersCollection.insertOne(user.toJson());
    return result.isSuccess;
  }
}
