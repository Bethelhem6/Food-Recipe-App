import 'package:dartz/dartz.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/model/auth_model.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthModel? authModel;
  AuthBloc({required this.authUsecase}) : super(AuthLoading()) {
    on<AuthLogin>(_onLogin);
    on<AuthUpdatePassword>(_onUpdatePassword);
    on<AuthResetPassword>(_onResetPassword);
    on<AuthLogout>(_onLogout);
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
}
