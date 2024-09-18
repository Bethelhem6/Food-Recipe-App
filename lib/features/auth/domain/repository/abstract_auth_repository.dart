import 'package:emebet/core/utils/utils.dart';
import 'package:emebet/features/auth/data/model/auth_model.dart';
import 'package:emebet/features/auth/data/model/parent.dart';
import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/domain/models/login_param.dart';
import 'package:emebet/features/auth/domain/models/reset_password_param.dart';

import '../models/change_password_param.dart';

abstract class AbstractAuthRepository {
  ResultFuture<AuthModel> login(LoginParam loginParam);
  ResultFuture<bool> changePassword(ChangePasswordParam param);
  ResultFuture<bool> resetPassword(ResetPasswordParam param);
  ResultFuture<bool> logout();
  ResultFuture<bool> checkParent(String phoneNumber);
  ResultFuture<bool> registerParent(RegistrationParam param);
  ResultFuture<Parent> updateParent(Parent param);
  ResultFuture<Parent> getParent();
}
