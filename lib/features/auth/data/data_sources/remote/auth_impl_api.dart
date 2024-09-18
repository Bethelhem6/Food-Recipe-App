import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emebet/core/local_storage/local_storage.dart';
import 'package:emebet/core/local_storage/tokens.dart';
import 'package:emebet/core/utils/log/app_logger.dart';
import 'package:emebet/features/auth/data/data_sources/remote/abstract_auth_api.dart';
import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/domain/models/change_password_param.dart';
import 'package:emebet/features/auth/domain/models/login_param.dart';
import 'package:emebet/features/auth/domain/models/reset_password_param.dart';

import '../../../../../core/network/error/dio_error_handler.dart';
import '../../../../../core/network/error/exceptions.dart';
import '../../../../../core/utils/constant/network_constant.dart';
import '../../model/auth_model.dart';
import '../../model/parent.dart';

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
        LocalStorage.setId(model.profile.id);
        LocalStorage.setUserInformation(model.profile);
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
  Future<Parent> getParent() async {
    try {
      final id = await LocalStorage.getId();

      final result = await dio.get(
        AuthEndpoint.getParent(id),
      );
      if (result.statusCode == 200) {
        if (result.data == null) {
          throw ServerException("Unknown Error", result.statusCode);
        }

        return Parent.fromJson(result.data);

        // return ;
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
      print(e.toString());
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

  @override
  Future<bool> checkParent(String phoneNumber) async {
    try {
      final result = await dio.get(AuthEndpoint.checkParent(phoneNumber));
      logger.info("from database ${result.statusCode}");
      logger.info(result.data);
      if (result.statusCode == 200) {
        bool response = result.data == "true" ? true : false;
        return response;
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
  Future<bool> registerParent(RegistrationParam param) async {
    try {
      final result = (await dio.post(AuthEndpoint.registerParent(),
          data: json.encode(param.toJson())));
      if (result.statusCode == 201) {
        if (result.data == null) {
          throw ServerException("Unknown Error", result.statusCode);
        }

        return true;
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
  Future<Parent> updateParent(Parent param) async {
    try {
      final result = (await dio.put(AuthEndpoint.updateParent(),
          data: json.encode(param.toJson())));
      print(result.statusCode);
      if (result.statusCode == 200) {
        if (result.data == null) {
          throw ServerException("Unknown Error", result.statusCode);
        }
        Parent parent = Parent.fromJson(result.data);
        LocalStorage.setId(parent.id);
        Profile profile = Profile(
          id: parent.id,
          name: parent.name,
          email: parent.email,
          phoneNumber: parent.phoneNumber,
          type: "",
          isActive: true,
          createdAt: parent.createdAt,
          updatedAt: parent.updatedAt,
        );
        LocalStorage.setUserInformation(profile);
        return Parent.fromJson(result.data);
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
}
