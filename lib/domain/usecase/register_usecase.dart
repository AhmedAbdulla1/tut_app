import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) {
    return _repository.register(RegisterRequest(
      userName: input.userName,
      email: input.email,
      password: input.password,
      phone: input.phone,
    ));
  }
}

class RegisterUseCaseInput {
  final String userName;
  final String email;
  final String password;
  final String phone;

  RegisterUseCaseInput({
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
  });
}
