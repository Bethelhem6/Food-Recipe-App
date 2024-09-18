import 'package:emebet/core/utils/utils.dart';
import 'package:emebet/features/notification/data/model/notification.dart';
import 'package:emebet/features/notification/domain/models/notification_param.dart';

abstract class AbstractNotificationsRepository {
  ResultFuture<List<NotificationModel>> getNotifications(
      NotificationParam param);
}
