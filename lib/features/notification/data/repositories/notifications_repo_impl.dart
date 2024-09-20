import 'package:dartz/dartz.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/repository/abstract_notifications_repository.dart'; 
import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../domain/models/notification_param.dart';
import '../data_sources/remote/notifications_impl_api.dart';
import '../model/notification.dart';

class NotificationsRepoImpl extends AbstractNotificationsRepository {
  final NotificationsImplApi notificationsImplApi;

  NotificationsRepoImpl(this.notificationsImplApi);

  @override
  ResultFuture<List<NotificationModel>> getNotifications(
      NotificationParam param) async {
    try {
      final result = await notificationsImplApi.getNotifications(param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
