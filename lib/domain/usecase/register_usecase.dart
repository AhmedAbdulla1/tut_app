import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class  RegisterUseCase extends BaseUseCase <RegisterUseCaseInput,Authentication>{

  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) {
    return _repository.login(LoginRequest(email: input.email, password: input.password));

  }

}

class RegisterUseCaseInput {
  final String email;
  final String password;

  RegisterUseCaseInput(this.email, this.password);
}