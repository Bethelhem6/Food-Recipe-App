import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart'; 
import 'package:flutter/foundation.dart';
import 'package:mvvm/core/network/logger_interceptor.dart';

import '../helper/helper.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/tokens.dart';
import '../utils/constant/network_constant.dart';
import '../utils/log/app_logger.dart';

class DioNetwork {
  static late Dio appAPI;
  static late Dio retryAPI;

  static void initDio() {
    appAPI = Dio(baseOptions(apiUrl));
    appAPI.interceptors.add(loggerInterceptor());
    appAPI.interceptors.add(appQueuedInterceptorsWrapper());

    retryAPI = Dio(baseOptions(apiUrl));
    retryAPI.interceptors.add(loggerInterceptor());
    retryAPI.interceptors.add(interceptorsWrapper());
  }

  static LoggerInterceptor loggerInterceptor() {
    return LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: true,
      requestHeader: true,
    );
  }

  ///__________App__________///

  /// App Api Queued Interceptor
  static QueuedInterceptorsWrapper appQueuedInterceptorsWrapper() {
    return QueuedInterceptorsWrapper(
      onRequest: (RequestOptions options, r) async {
        Map<String, dynamic> headers = Helper.getHeaders();

        if (kDebugMode) {
          print(json.encode(headers));
        }

        Tokens tokens = await LocalStorage.getTokens();
        if (tokens.accessToken != null) {
          headers["Authorization"] = 'Bearer ${tokens.accessToken}';
        }
        options.headers = headers;
        appAPI.options.headers = headers;
        return r.next(options);
      },
      onError: (error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          // Attempt to refresh the token
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the original request
            final options = error.response!.requestOptions;
            final newHeaders = Helper.getHeaders();
            Tokens tokens = await LocalStorage.getTokens();
            if (tokens.accessToken != null) {
              newHeaders["Authorization"] = 'Bearer ${tokens.accessToken}';
            }
            options.headers = newHeaders;
            final response = await appAPI.fetch(options);
            return handler.resolve(response);
          } else {
            // navigatorKey.currentState?.pushNamedAndRemoveUntil(
            //   LoginScreen.routeName,
            //   (_) => false,
            // );

            // Navigator.pushNamedAndRemoveUntil(
            //   Constants.globalContext!,
            //   LoginScreen.routeName,
            //   (_) => false,
            // );
          }
        }
        return handler.next(error);
      },
      onResponse: (Response<dynamic> response,
          ResponseInterceptorHandler handler) async {
        JsonEncoder encoder = const JsonEncoder.withIndent('  ');
        String formattedJson = encoder.convert(response.data);
        developer.log(formattedJson);

        return handler.next(response);
      },
    );
  }

  /// App interceptor
  static InterceptorsWrapper interceptorsWrapper() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, r) async {
        if (kDebugMode) {
          print('------------------------------ refresh access token ');
        }
        Map<String, dynamic> headers = Helper.getHeaders();
        Tokens tokens = await LocalStorage.getTokens();
        if (tokens.refreshToken != null) {
          headers["x-refresh-token"] = '${tokens.refreshToken}';
        }
        options.headers = headers;
        appAPI.options.headers = headers;

        return r.next(options);
      },
      onResponse: (response, handler) async {
        if ("${(response.data["code"] ?? "0")}" != "0") {
          return handler.resolve(response);
        } else {
          return handler.next(response);
        }
      },
      onError: (error, handler) {
        try {
          return handler.next(error);
        } catch (e) {
          return handler.reject(error);
        }
      },
    );
  }

  static BaseOptions baseOptions(String url) {
    Map<String, dynamic> headers = Helper.getHeaders();

    return BaseOptions(
        baseUrl: url,
        validateStatus: (s) {
          return s! < 300;
        },
        headers: headers..removeWhere((key, value) => value == null),
        responseType: ResponseType.json);
  }

  static Future<bool> _refreshToken() async {
    try {
      Tokens tokens = await LocalStorage.getTokens();
      if (tokens.refreshToken == null) {
        return false;
      }

      final response = await retryAPI.post(
        AuthEndpoint.refreshToken(),
      );
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 201) {
        final newTokens = Tokens(
          accessToken: response.data['accessToken'],
          refreshToken: tokens.refreshToken,
        );
        // navigatorKey.currentState?.pushNamedAndRemoveUntil(
        //   LoginScreen.routeName,
        //   (_) => false,
        // );

        await LocalStorage.setTokens(newTokens);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
