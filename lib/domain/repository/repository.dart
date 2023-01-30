import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, UserCredential>> login(LoginRequest loginRequest);
  Future<Either<Failure, UserCredential>> register(RegisterRequest registerRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
}
