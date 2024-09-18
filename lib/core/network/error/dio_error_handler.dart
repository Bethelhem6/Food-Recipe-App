import 'dart:io';

import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  String errorDescription = "";
  if (error.error is SocketException) {
    SocketException socketException = error.error as SocketException;

    if (socketException.osError?.errorCode == 101 ||
        socketException.osError?.errorCode == 7 ||
        socketException.osError?.errorCode == 8) {
      errorDescription = 'Connect to internet and try again!';
    } else {
      errorDescription =
          "Apologies for the inconvenience, our server is currently not responding and will be back online shortly.";
    }
    return errorDescription;
  } else {
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioExceptionType.connectionError:
        errorDescription = "Internet Connection Problem.";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        {
          if (error.response?.data['code'] != null &&
              (error.response?.data['code'] ?? "0") != "0") {
            errorDescription = error.response?.data['msg'];
          } else {
            if (error.response?.statusCode == 200 &&
                ("${(error.response?.data["statusCode"] ?? "0")}" != "0")) {
              if ((error.response?.data['data'] ?? "") != "") {
                errorDescription = (error.response?.data['data'] ?? "");
              } else {
                errorDescription = "Unknown Error";
              }
            } else if (error.response?.statusCode == 422) {
              errorDescription = (error.response?.data["message"] != null &&
                      error.response?.data["message"]["validations"] != null)
                  ? error
                      .response?.data["message"]["validations"].values.first[0]
                  : error.response?.data["errors"] == null
                      ? error.response?.data['fault']['faultstring'] ??
                          "Unknown Error"
                      : error.response?.data["errors"].values.first[0] ??
                          error.response?.data['fault']['faultstring'] ??
                          "Unknown Error";
            } else if (error.response?.statusCode == 413) {
              errorDescription = error.response!.statusMessage ?? "";
            } else if (error.response?.statusCode == 400) {
              errorDescription = error.response?.data['message']
                      ?.toString()
                      .replaceAll("[", '')
                      .replaceAll("]", '') ??
                  "Unknown Error";
            } else if (error.response?.statusCode == 401) {
              errorDescription =
                  error.response?.data['message'] ?? "Unknown Error";
            } else if (error.response?.statusCode == 403) {
              errorDescription = error.response?.data is String
                  ? "403 Forbidden"
                  : error.response?.data['message'] ?? "Unknown Error";
            } else if (error.response?.statusCode == 404) {
              errorDescription = error.response?.data is String
                  ? "404 Unknown Error"
                  : error.response?.data['message'] ?? "Unknown Error";
            } else if (error.response?.statusCode == 409) {
              errorDescription = error.response?.data['message'] +
                      ",\n Minutes left to join: " +
                      error.response?.data["message"].toString() ??
                  "Unknown Error";
            } else if (error.response?.statusCode == 429) {
              errorDescription = error.response?.data['message'];
            } else {
              errorDescription =
                  "Received invalid status code: ${error.response?.statusCode}";
            }
          }

          break;
        }

      case DioExceptionType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        break;

      case DioExceptionType.unknown:
        break;
    }

    return errorDescription;
  }
}
