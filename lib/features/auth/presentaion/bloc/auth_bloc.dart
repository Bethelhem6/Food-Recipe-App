import 'package:dartz/dartz.dart';
import 'package:emebet/core/network/error/failures.dart';
import 'package:emebet/features/auth/data/model/parent.dart';
import 'package:emebet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_event.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/auth_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthModel? authModel;
  AuthBloc({required this.authUsecase}) : super(AuthLoading()) {
    on<AuthLogin>(_onLogin);
    on<AuthUpdatePassword>(_onUpdatePassword);
    on<AuthResetPassword>(_onResetPassword);
    on<AuthLogout>(_onLogout);
    on<AuthCheckPhoneNumber>(_onAuthCheckPhoneNumber);
    on<AuthRegisterParent>(_onAuthRegisterParent);

    on<AuthGetParent>(_onAuthGetParent);
    on<AuthUpdateParent>(_onAuthUpdateParent);
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    Either<Failure, AuthModel> result = await authUsecase.login(event.param);
    result.fold(
        (Failure failure) => emit(
              AuthLoginFaulire(failure: failure),
            ), (AuthModel model) {
      authModel = model;
      emit(AuthLoginSuccess(model: model));
    });
  }

  void _onUpdatePassword(
      AuthUpdatePassword event, Emitter<AuthState> emit) async {
    emit(AuthUpdatePasswordLoading());
    Either<Failure, bool> result =
        await authUsecase.changePassword(event.param);
    result.fold(
        (Failure failure) => emit(
              AuthUpdatePasswordFaulire(failure: failure),
            ), (bool changed) {
      emit(AuthUpdatePasswordSuccess(changed: changed));
    });
  }

  void _onResetPassword(
      AuthResetPassword event, Emitter<AuthState> emit) async {
    emit(AuthResetPasswordLoading());
    Either<Failure, bool> result = await authUsecase.resetPassword(event.param);
    result.fold(
        (Failure failure) => emit(
              AuthResetPasswordFaulire(failure: failure),
            ), (bool isResetted) {
      emit(AuthResetPasswordSuccess(isResetted: isResetted));
    });
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLogoutLoading());
    Either<Failure, bool> result = await authUsecase.logout();
    result.fold(
        (Failure failure) => emit(
              AuthLogoutFaulire(failure: failure),
            ), (bool logout) {
      emit(AuthLogoutSuccess(logout: logout));
    });
  }

  void _onAuthCheckPhoneNumber(
      AuthCheckPhoneNumber event, Emitter<AuthState> emit) async {
    emit(AuthCheckPhoneNumberLoading());
    Either<Failure, bool> result =
        await authUsecase.checkPhoneNumber(event.phoneNumber);
    result.fold(
        (Failure failure) => emit(
              AuthCheckPhoneNumberFaulire(failure: failure),
            ), (bool isParentExist) {
      emit(AuthCheckPhoneNumberSuccess(isParentExist: isParentExist));
    });
  }

  void _onAuthRegisterParent(
      AuthRegisterParent event, Emitter<AuthState> emit) async {
    emit(AuthRegisterParentLoading());
    Either<Failure, bool> result =
        await authUsecase.registerParent(event.param);
    result.fold(
        (Failure failure) => emit(
              AuthRegisterParentFaulire(failure: failure),
            ), (bool isCreated) {
      emit(AuthRegisterParentSuccess(isCreated: isCreated));
    });
  }

  void _onAuthGetParent(AuthGetParent event, Emitter<AuthState> emit) async {
    emit(AuthGetParentLoading());
    Either<Failure, Parent> result = await authUsecase.getParent();
    result.fold(
        (Failure failure) => emit(
              AuthGetParentFaulire(failure: failure),
            ), (Parent parent) {
      emit(AuthGetParentSuccess(parent: parent));
    });
  }

  void _onAuthUpdateParent(
      AuthUpdateParent event, Emitter<AuthState> emit) async {
    emit(AuthUpdateParentLoading());
    Either<Failure, Parent> result =
        await authUsecase.updateParent(event.param);
    result.fold(
        (Failure failure) => emit(
              AuthUpdateParentFaulire(failure: failure),
            ), (Parent parent) {
      emit(AuthUpdateParentSuccess(parent: parent));
    });
  }
}
