import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, UserCredential> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, UserCredential>> execute(RegisterUseCaseInput input) {
    return _repository.register(RegisterRequest(
      userName: input.userName,
      countryCode: input.countryCode,
      phone: input.phone,
      email: input.email,
      password: input.password,
      profilePicture: input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  final String userName;
  final Widget countryCode;
  final String phone;
  final String email;
  final String password;
  final String profilePicture;

  RegisterUseCaseInput({
    required this.userName,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
