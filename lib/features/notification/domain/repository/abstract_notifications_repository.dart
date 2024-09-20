import '../../../../core/utils/utils.dart';
import '../../data/model/notification.dart'; 
import '../models/notification_param.dart';

abstract class AbstractNotificationsRepository {
  ResultFuture<List<NotificationModel>> getNotifications(
      NotificationParam param);
}
