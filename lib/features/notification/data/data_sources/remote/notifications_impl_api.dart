import 'package:dio/dio.dart'; 

import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/utils/constant/network_constant.dart';
import '../../../../../core/utils/log/app_logger.dart';
import '../../../domain/models/notification_param.dart';
import '../../model/notification.dart';
import 'abstract_notifications_api.dart';

class NotificationsImplApi extends AbstractNotificationsApi {
  final Dio dio;

  CancelToken cancelToken = CancelToken();

  NotificationsImplApi(this.dio);

  @override
  Future<List<NotificationModel>> getNotifications(
      NotificationParam param) async {
    try {
      final result = await dio.get(
        NotificationEndPoint.getNotifications(param),
      );
      logger.info("from database ${result.statusCode}");

      if (result.statusCode == 200) {
        List<NotificationModel> notifiacations = (result.data["data"] as List)
            .map((e) => NotificationModel.fromJson(e))
            .toList();
        return notifiacations;
      } else {
        String message = result.data['message'].toString();
        message = message.replaceAll("[", '');
        message = message.replaceAll("]", '');
        throw ServerException(message, result.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
