import 'package:dartz/dartz.dart';
import 'package:emebet/core/utils/utils.dart';
import 'package:emebet/features/auth/data/model/parent.dart';
import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/domain/models/login_param.dart';
import 'package:emebet/features/auth/domain/models/reset_password_param.dart';
import 'package:emebet/features/auth/domain/repository/abstract_auth_repository.dart';

import '../../../../core/utils/usecases/usecase.dart';
import '../../data/model/auth_model.dart';
import '../models/change_password_param.dart';

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

  ResultFuture<bool> checkPhoneNumber(String phone) async {
    final result = await repository.checkParent(phone);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }

  ResultFuture<bool> registerParent(RegistrationParam param) async {
    final result = await repository.registerParent(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }

  ResultFuture<Parent> updateParent(Parent param) async {
    final result = await repository.updateParent(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }


  ResultFuture<Parent> getParent() async {
    final result = await repository.getParent();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
