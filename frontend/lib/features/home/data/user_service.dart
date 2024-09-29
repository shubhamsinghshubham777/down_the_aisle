import 'package:core/models/auth/dta_user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String? baseUrl}) = _UserService;

  @GET('/user/profile')
  Future<HttpResponse<DTAUser>> getUserProfile();

  @PATCH('/user/profile')
  Future<HttpResponse<void>> updateUserProfile(@Body() DTAUser user);
}
