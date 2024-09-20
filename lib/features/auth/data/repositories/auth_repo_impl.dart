import 'package:dartz/dartz.dart'; 

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/models/change_password_param.dart';
import '../../domain/models/login_param.dart';
import '../../domain/models/reset_password_param.dart';
import '../../domain/repository/abstract_auth_repository.dart';
import '../data_sources/remote/auth_impl_api.dart';
import '../model/auth_model.dart';

class AuthRepoImpl extends AbstractAuthRepository {
  final AuthImplApi authImplApi;

  AuthRepoImpl(this.authImplApi);

  @override
  ResultFuture<AuthModel> login(LoginParam loginParam) async {
    try {
      final result = await authImplApi.login(loginParam);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<bool> changePassword(ChangePasswordParam param) async {
    try {
      final result = await authImplApi.changePassword(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<bool> resetPassword(ResetPasswordParam param) async {
    try {
      final result = await authImplApi.resetPassword(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<bool> logout() async {
    try {
      final result = await authImplApi.logout();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
