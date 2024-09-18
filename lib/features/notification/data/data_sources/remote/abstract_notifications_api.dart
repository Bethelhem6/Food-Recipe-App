import '../../../domain/models/notification_param.dart';
import '../../model/notification.dart';

abstract class AbstractNotificationsApi {
  Future<List<NotificationModel>> getNotifications(NotificationParam param);
}
