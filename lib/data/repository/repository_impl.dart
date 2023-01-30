import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetWorkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, UserCredential>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final UserCredential credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginRequest.email,
          password: loginRequest.password,
        );
        return Right(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return Left(
            Failure(
              code: ApiInternalStatus.failure,
              message: 'No user found for that email.',
            ),
          );
        } else if (e.code == 'wrong-password') {
          return Left(
            Failure(
              code: ApiInternalStatus.failure,
              message: 'Wrong password provided for that user.',
            ),
          );
        }
      } catch (error) {
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    }
    return Left(
      DataSource.noInternetConnection.getFailure(),
    );
  }

  @override
  Future<Either<Failure, UserCredential>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerRequest.email,
          password: registerRequest.password,

        );
        return Right(
          credential,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return Left(
            Failure(
              code: ApiInternalStatus.failure,
              message: 'The password provided is too weak.',
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          return Left(
            Failure(
              code: ApiInternalStatus.failure,
              message: 'The account already exists for that email.',
            ),
          );
        }
      } catch (error) {
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    }
    return Left(
      DataSource.noInternetConnection.getFailure(),
    );
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      final ForgotPasswordResponse response =
          await _remoteDataSource.forgotPasswordResponse(email);
      try {
        if (response.status == ApiInternalStatus.success) {
          return Right(
            response.toString(),
          );
        } else {
          return Left(
            Failure(
              code: ApiInternalStatus.failure,
              message: response.message ?? ResponseMessage.customDefault,
            ),
          );
        }
      } catch (error) {
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      return Left(
        DataSource.noInternetConnection.getFailure(),
      );
    }
  }
}
