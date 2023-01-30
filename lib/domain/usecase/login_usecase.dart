import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class  LoginUseCase extends BaseUseCase <LoginUseCaseInput,UserCredential>{

  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, UserCredential>> execute(LoginUseCaseInput input) {
    return _repository.login(LoginRequest(email: input.email, password: input.password));

  }

}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput(this.email, this.password);
}