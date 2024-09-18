import 'package:dartz/dartz.dart';
import 'package:emebet/features/notification/data/model/notification.dart';
import 'package:emebet/features/notification/domain/usecases/notifications_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/models/notification_param.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationsUsecase notificationsUsecase;
  NotificationBloc({required this.notificationsUsecase})
      : super(NotificationInitial()) {
    on<NotificationGets>(_onFetchNotification);
    on<NotificationGetsMore>(_onFetchMoreNotification);
  }

  //////////////////////////////////////////////
  ///  get notifications
  _onFetchNotification(
      NotificationGets event, Emitter<NotificationState> emit) async {
    emit(NotificationGetsLoading());
    Either<Failure, List<NotificationModel>> response =
        await notificationsUsecase.getNotifications(event.param);
    response.fold(
      (Failure failure) => emit(
        NotificationGetsFaulire(failure: failure),
      ),
      (List<NotificationModel> success) =>
          emit(NotificationGetsSuccess(notifiacations: success)),
    );
  }

  //////////////////////////////////////////////
  ///  get more notifications
  _onFetchMoreNotification(
      NotificationGetsMore event, Emitter<NotificationState> emit) async {
    emit(NotificationGetsMoreLoading());
    Either<Failure, List<NotificationModel>> response =
        await notificationsUsecase.getNotifications(event.param);
    response.fold(
      (Failure failure) => emit(
        NotificationGetsMoreFaulire(failure: failure),
      ),
      (List<NotificationModel> success) =>
          emit(NotificationGetsMoreSuccess(notifiacations: success)),
    );
  }
}
