import '../../../../core/utils/utils.dart';
import '../../data/model/auth_model.dart';
import '../models/change_password_param.dart';
import '../models/login_param.dart';
import '../models/reset_password_param.dart';

abstract class AbstractAuthRepository {
  ResultFuture<AuthModel> login(LoginParam loginParam);
  ResultFuture<bool> changePassword(ChangePasswordParam param);
  ResultFuture<bool> resetPassword(ResetPasswordParam param);
  ResultFuture<bool> logout();
}
