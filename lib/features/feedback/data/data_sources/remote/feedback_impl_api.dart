import 'dart:convert';

import 'package:dio/dio.dart'; 

import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/utils/constant/network_constant.dart';

import '../../../../../core/utils/log/app_logger.dart';
import '../../../domain/models/feedback_param.dart';
import 'abstract_feedback_api.dart';

class FeedbackImplApi extends AbstractFeedbackApi {
  final Dio dio;

  CancelToken cancelToken = CancelToken();

  FeedbackImplApi(this.dio);

  @override
  Future<bool> sendFeedback(FeedbackParam param) async {
    try {
      final result = await dio.post(
        FeedBackEndpoint.sendFeedback(),
        data: json.encode(
          param.toJson(),
        ),
      );
      logger.info("from database ${result.statusCode}");

      if (result.statusCode == 201) {
        return true;
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
