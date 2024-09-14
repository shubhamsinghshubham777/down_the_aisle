import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';

import '../src/repositories/credential_manager.dart';
import '../src/repositories/user_repository.dart';

class MockRequestContext extends Mock implements RequestContext {}

class MockUserRepository extends Mock implements UserRepository {}

class MockCredentialManager extends Mock implements CredentialManager {}
