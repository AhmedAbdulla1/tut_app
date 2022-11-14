
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/app/constant.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseurl)
abstract class  AppServicesClient{
  factory AppServicesClient(Dio dio,{String baseUrl}) =_AppServicesClient;
}