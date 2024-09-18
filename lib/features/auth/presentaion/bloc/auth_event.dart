
import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/domain/models/change_password_param.dart';
import 'package:emebet/features/auth/domain/models/login_param.dart';
import 'package:emebet/features/auth/domain/models/reset_password_param.dart';

import '../../data/model/parent.dart';

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

class AuthCheckPhoneNumber extends AuthEvent {
  String phoneNumber;
  AuthCheckPhoneNumber({required this.phoneNumber});
}

class AuthRegisterParent extends AuthEvent {
  RegistrationParam param;
  AuthRegisterParent({required this.param});
}

class AuthUpdateParent extends AuthEvent {
  Parent param;
  AuthUpdateParent({required this.param});
}

class AuthGetKidByCommonName extends AuthEvent {
  String city;
  AuthGetKidByCommonName({required this.city});
}

class AuthAssignKid extends AuthEvent {
  String kidId;
  AuthAssignKid({required this.kidId});
}

class AuthUnAssignKid extends AuthEvent {
  String kidId;
  AuthUnAssignKid({required this.kidId});
}

class AuthGetParent extends AuthEvent {
  AuthGetParent();
}
