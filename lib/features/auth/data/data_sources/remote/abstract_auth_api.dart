import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/domain/models/reset_password_param.dart';

import '../../../domain/models/change_password_param.dart';
import '../../../domain/models/login_param.dart';
import '../../model/auth_model.dart';
import '../../model/parent.dart';

abstract class AbstractAuthApi {
  Future<AuthModel> login(LoginParam loginParam);
  Future<bool> logout();
  Future<bool> changePassword(ChangePasswordParam param);
  Future<bool> resetPassword(ResetPasswordParam param);
  Future<bool> checkParent(String phoneNumber);
  Future<bool> registerParent(RegistrationParam param);
  Future<Parent> updateParent(Parent param);
  Future<Parent> getParent();
}
