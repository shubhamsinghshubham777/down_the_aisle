import 'package:core/models/auth/dta_user.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../utils/extensions.dart';

abstract class UserRepository {
  Future<DTAUser?> findUser(String email);
  Future<bool> upsertUser(DTAUser? user);
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
  Future<bool> upsertUser(DTAUser? user) async {
    if (user == null) return false;
    final dbUser = await findUser(user.email);
    final modifier = modify;

    if (user.firstName != dbUser?.firstName) {
      modifier.set('firstName', user.firstName);
    }

    if (user.email != dbUser?.email) {
      modifier.set('email', user.email);
    }

    if (user.gender != dbUser?.gender) {
      modifier.set('gender', user.gender.name);
    }

    if (user.hashedPassword != dbUser?.hashedPassword) {
      modifier.set('hashedPassword', user.hashedPassword);
    }

    if (user.passwordSalt != dbUser?.passwordSalt) {
      modifier.set('passwordSalt', user.passwordSalt);
    }

    if (user.weddingBudget != dbUser?.weddingBudget) {
      modifier.set('weddingBudget', user.weddingBudget);
    }

    if (user.weddingDate != dbUser?.weddingDate) {
      modifier.set('weddingDate', user.weddingDate);
    }

    final result = await mongoDb.usersCollection.updateOne(
      where.eq('email', user.email),
      modifier,
      upsert: true,
    );
    return result.isSuccess;
  }
}
