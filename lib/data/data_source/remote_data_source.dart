
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> loginResponse(
    LoginRequest loginRequest,
  );
  Future<ForgotPasswordResponse> forgotPasswordResponse(String email);
  Future<AuthenticationResponse> registerResponse(
      RegisterRequest registerRequest,
      );
  Future<HomeResponse>homeResponse();
  Future<StoresDetailsResponse>storeDetailsResponse();

}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImpl(
    this._appServicesClient,
  );

  @override
  Future<AuthenticationResponse> loginResponse(
      LoginRequest loginRequest) async {
    return await _appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }
  @override
  Future<ForgotPasswordResponse> forgotPasswordResponse(String email) async {
    return await _appServicesClient.forgotPassword(
      email,
    );
  }
  @override
  Future<AuthenticationResponse> registerResponse(RegisterRequest registerRequest)async {
    return await _appServicesClient.register(
      registerRequest.email,
      registerRequest.password,
      registerRequest.userName,
      registerRequest.phone,
    );
  }
  @override
  Future<HomeResponse> homeResponse()async {
    return await _appServicesClient.home();
  }
  @override
  Future<StoresDetailsResponse> storeDetailsResponse()async {
    return await _appServicesClient.getStoreDetails();
  }
}
