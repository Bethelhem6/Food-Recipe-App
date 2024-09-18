import 'package:emebet/core/network/error/failures.dart';
import 'package:emebet/features/auth/data/model/auth_model.dart';
import 'package:emebet/features/auth/data/model/parent.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthLoginLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoginSuccess extends AuthState {
  final AuthModel model;
  AuthLoginSuccess({required this.model});
  @override
  List<Object?> get props => [];
}

class AuthLoginFaulire extends AuthState {
  final Failure failure;
  AuthLoginFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthGetKidsLoading extends AuthState {
  @override
  List<Object?> get props => [];
}


class AuthGetKidsFaulire extends AuthState {
  final Failure failure;
  AuthGetKidsFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthUpdatePasswordLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthUpdatePasswordSuccess extends AuthState {
  final bool changed;
  AuthUpdatePasswordSuccess({required this.changed});
  @override
  List<Object?> get props => [];
}

class AuthUpdatePasswordFaulire extends AuthState {
  final Failure failure;
  AuthUpdatePasswordFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthLogoutLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLogoutSuccess extends AuthState {
  final bool logout;
  AuthLogoutSuccess({required this.logout});
  @override
  List<Object?> get props => [];
}

class AuthLogoutFaulire extends AuthState {
  final Failure failure;
  AuthLogoutFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthCheckPhoneNumberLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthCheckPhoneNumberSuccess extends AuthState {
  final bool isParentExist;
  AuthCheckPhoneNumberSuccess({required this.isParentExist});
  @override
  List<Object?> get props => [];
}

class AuthCheckPhoneNumberFaulire extends AuthState {
  final Failure failure;
  AuthCheckPhoneNumberFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthRegisterParentLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthRegisterParentSuccess extends AuthState {
  final bool isCreated;
  AuthRegisterParentSuccess({required this.isCreated});
  @override
  List<Object?> get props => [];
}

class AuthRegisterParentFaulire extends AuthState {
  final Failure failure;
  AuthRegisterParentFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthGetKidByCommonNameLoading extends AuthState {
  @override
  List<Object?> get props => [];
}


///////////////////////////////////////////////////////////
///
class AuthAssignKidLoading extends AuthState {
  @override
  List<Object?> get props => [];
}



class AuthAssignKidFaulire extends AuthState {
  final Failure failure;
  AuthAssignKidFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}




///////////////////////////////////////////////////////////
///
class AuthResetPasswordLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthResetPasswordSuccess extends AuthState {
  final bool isResetted;
  AuthResetPasswordSuccess({required this.isResetted});
  @override
  List<Object?> get props => [];
}

class AuthResetPasswordFaulire extends AuthState {
  final Failure failure;
  AuthResetPasswordFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthGetParentLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthGetParentSuccess extends AuthState {
  final Parent parent;
  AuthGetParentSuccess({required this.parent});
  @override
  List<Object?> get props => [];
}

class AuthGetParentFaulire extends AuthState {
  final Failure failure;
  AuthGetParentFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}

///////////////////////////////////////////////////////////
///
class AuthUpdateParentLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthUpdateParentSuccess extends AuthState {
  final Parent parent;
  AuthUpdateParentSuccess({required this.parent});
  @override
  List<Object?> get props => [];
}

class AuthUpdateParentFaulire extends AuthState {
  final Failure failure;
  AuthUpdateParentFaulire({required this.failure});
  @override
  List<Object?> get props => [];
}
