import 'package:dartz/dartz.dart';
import 'package:mvvm/features/notification/data/model/notification.dart';
import '../../../../core/utils/utils.dart'; 

import '../../../../core/utils/usecases/usecase.dart';
import '../models/notification_param.dart';
import '../repository/abstract_notifications_repository.dart';

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
