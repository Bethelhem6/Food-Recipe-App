import 'package:dartz/dartz.dart';
import 'package:emebet/core/utils/utils.dart';
import 'package:emebet/features/auth/data/data_sources/remote/auth_impl_api.dart';
import 'package:emebet/features/auth/data/model/auth_model.dart';
import 'package:emebet/features/auth/data/model/parent.dart';
import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/domain/models/login_param.dart';
import 'package:emebet/features/auth/domain/models/reset_password_param.dart';
import 'package:emebet/features/auth/domain/repository/abstract_auth_repository.dart';

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../domain/models/change_password_param.dart';

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

  @override
  ResultFuture<bool> checkParent(String phoneNumber) async {
    try {
      final result = await authImplApi.checkParent(phoneNumber);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<bool> registerParent(RegistrationParam param) async {
    try {
      final result = await authImplApi.registerParent(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<Parent> updateParent(Parent param) async {
    try {
      final result = await authImplApi.updateParent(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  ResultFuture<Parent> getParent() async {
    try {
      final result = await authImplApi.getParent();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
