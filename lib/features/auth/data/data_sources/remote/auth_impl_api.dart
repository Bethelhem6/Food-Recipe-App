import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../core/local_storage/local_storage.dart';
import '../../../../../core/local_storage/tokens.dart';
import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/utils/constant/network_constant.dart';
import '../../../../../core/utils/log/app_logger.dart';
import '../../../domain/models/change_password_param.dart';
import '../../../domain/models/login_param.dart';
import '../../../domain/models/reset_password_param.dart';
import '../../model/auth_model.dart';
import 'abstract_auth_api.dart';

class AuthImplApi extends AbstractAuthApi {
  final Dio dio;

  CancelToken cancelToken = CancelToken();

  AuthImplApi(this.dio);

  @override
  Future<AuthModel> login(LoginParam loginParam) async {
    try {
      final result = (await dio.post(AuthEndpoint.login(),
          data: json.encode(loginParam.toJson())));
      if (result.statusCode == 201) {
        if (result.data == null) {
          throw ServerException("Unknown Error", result.statusCode);
        }
        Tokens tokens = Tokens.fromJson(result.data);
        LocalStorage.setTokens(tokens);

        AuthModel model = AuthModel.fromJson(result.data);
        LocalStorage.setId(model.id);
        LocalStorage.setUserInformation(model);
        return model;
      } else {
        throw ServerException(result.data['message'], result.statusCode);
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

  @override
  Future<bool> changePassword(ChangePasswordParam param) async {
    try {
      final data = json.encode(param.toJson());
      final result = await dio.post(AuthEndpoint.changePassword(), data: data);
      logger.info("from database ${result.data}");
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

  @override
  Future<bool> resetPassword(ResetPasswordParam param) async {
    try {
      final data = json.encode(param.toJson());
      final result = await dio.post(AuthEndpoint.resetPassword(), data: data);
      logger.info("from database ${result.data}");
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

  @override
  Future<bool> logout() async {
    try {
      final result = await dio.post(AuthEndpoint.logout());
      logger.info("from database ${result.statusCode}");
      if (result.statusCode == 201) {
        await LocalStorage.clearLocalStorage();
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
