import 'package:core/models/auth/dta_user.dart';
import 'package:core/models/auth/login_request.dart';
import 'package:core/models/auth/register_request.dart';
import 'package:core/models/auth/tokens.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String? baseUrl}) = _AuthService;

  @POST('/auth/login')
  Future<HttpResponse<Tokens>> loginUser(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<HttpResponse<String>> registerUser(@Body() RegisterRequest request);

  @GET('/user/profile')
  Future<HttpResponse<DTAUser>> getUserProfile();
}
