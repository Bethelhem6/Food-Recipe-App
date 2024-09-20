import '../../../domain/models/reset_password_param.dart';

import '../../../domain/models/change_password_param.dart';
import '../../../domain/models/login_param.dart';
import '../../model/auth_model.dart';

abstract class AbstractAuthApi {
  Future<AuthModel> login(LoginParam loginParam);
  Future<bool> logout();
  Future<bool> changePassword(ChangePasswordParam param);
  Future<bool> resetPassword(ResetPasswordParam param);
}
