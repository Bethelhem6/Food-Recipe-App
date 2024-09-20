import '../../domain/models/change_password_param.dart';
import '../../domain/models/login_param.dart';
import '../../domain/models/reset_password_param.dart'; 

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  LoginParam param;
  AuthLogin({required this.param});
}

class AuthLogout extends AuthEvent {}

class AuthGetKids extends AuthEvent {}

class AuthUpdatePassword extends AuthEvent {
  ChangePasswordParam param;
  AuthUpdatePassword({required this.param});
}

class AuthResetPassword extends AuthEvent {
  ResetPasswordParam param;
  AuthResetPassword({required this.param});
}
