import 'package:dartz/dartz.dart';
import 'package:emebet/core/utils/utils.dart';
import 'package:emebet/features/notification/data/model/notification.dart';
import 'package:emebet/features/notification/domain/models/notification_param.dart';
import 'package:emebet/features/notification/domain/repository/abstract_notifications_repository.dart';

import '../../../../core/utils/usecases/usecase.dart';

class NotificationsUsecase extends UseCase {
  final AbstractNotificationsRepository repository;

  NotificationsUsecase(this.repository);

  ResultFuture<List<NotificationModel>> getNotifications(
      NotificationParam param) async {
    final result = await repository.getNotifications(param);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
