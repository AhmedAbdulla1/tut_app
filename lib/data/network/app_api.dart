
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/app/constant.dart';
import 'package:tut_app/data/response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseurl,)
abstract class  AppServicesClient{
  factory AppServicesClient(Dio dio,{String baseUrl}) =_AppServicesClient;
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      );

  Future<AuthenticationResponse> register(
      @Field("userName") String userName,
      @Field("email") String email,
      @Field("password") String password,
      @Field("phone") String phone,
      );
}