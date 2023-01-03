import 'dart:math';

import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> loginResponse(
    LoginRequest loginRequest,
  );
  Future<AuthenticationResponse> registerResponse(
      RegisterRequest registerRequest,
      );
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
  Future<AuthenticationResponse> registerResponse(RegisterRequest registerRequest)async {
    return await _appServicesClient.register(
      registerRequest.email,
      registerRequest.password,
      registerRequest.userName,
    );
  }
}
