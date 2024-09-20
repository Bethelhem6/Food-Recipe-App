import 'package:dartz/dartz.dart';
import 'package:mvvm/core/utils/utils.dart';
import 'package:mvvm/features/auth/domain/models/reset_password_param.dart'; 

import '../../../../core/utils/usecases/usecase.dart';
import '../../data/model/auth_model.dart';
import '../models/change_password_param.dart';
import '../models/login_param.dart';
import '../repository/abstract_auth_repository.dart';

class AuthUsecase extends UseCase {
  final AbstractAuthRepository repository;

  AuthUsecase(this.repository);

  ResultFuture<AuthModel> login(LoginParam loginParam) async {
    final result = await repository.login(loginParam);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }

  ResultFuture<bool> changePassword(ChangePasswordParam param) async {
    final result = await repository.changePassword(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }

  ResultFuture<bool> resetPassword(ResetPasswordParam param) async {
    final result = await repository.resetPassword(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }

  ResultFuture<bool> logout() async {
    final result = await repository.logout();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
