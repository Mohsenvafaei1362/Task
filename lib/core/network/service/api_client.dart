import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:testproject/features/login/data/models/request/login_request.dart';
import 'package:testproject/features/login/data/models/response/login_response.dart';
import 'package:testproject/features/register/data/models/request/register_request.dart';
import 'package:testproject/features/register/data/models/response/register_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  //! لاگین
  @POST('auth/login')
  Future<HttpResponse<LoginResponse>> signIn(@Body() LoginRequest loginRequest);

  //! ثبت نام
  @POST('users/add')
  Future<HttpResponse<RegisterResponse>> signUp(
    @Body() RegisterRequest registerRequest,
  );
}
