import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../singleton/shared_pref.dart';
import '../utility/customStrings.dart';
import '../utility/keys.dart';
import 'api_url.dart';

class AppInterceptors extends InterceptorsWrapper {
  final Dio dio;
  final int maxCharactersPerLine = 200;
  final int maxRetryCount = 3; // Maximum number of retries
  final int retryDelayMs = 10000; // Delay between retries in milliseconds

  AppInterceptors({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      CustomStrings().deviceType: SharedPref.getString(
        CustomStrings().deviceType,
      ),
      CustomStrings().token: SharedPref.getString(CustomStrings().token),
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //debugPrint("<-- STATUS : ${response.statusCode}");
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    RequestOptions requestOptions = err.requestOptions;

    if (shouldRetry(err)) {
      int retryCount = requestOptions.extra["retryCount"] ?? 0;

      if (retryCount < maxRetryCount) {
        requestOptions.extra["retryCount"] = retryCount + 1;
        debugPrint(
          "Retrying request... Attempt: ${retryCount + 1} for ${requestOptions.uri}",
        );

        await Future.delayed(Duration(milliseconds: retryDelayMs));
        try {
          final response = await dio.fetch(requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return super.onError(e as DioException, handler);
        }
      }
    }

    switch (statusCode) {
      case 401:
       /* if (requestOptions.path.contains(ApiUrl.registrationVerifyUrl)) {
        } else {
          _redirectToHomePage();
        }*/
        break;
      case 403:
      case 404:
      case 500:
      case 502:
        break;
      default:
        break;
    }

    debugPrint(
      "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}",
    );
    return super.onError(err, handler);
  }

  // Determines if the request should be retried
  bool shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        (err.response?.statusCode == 500 || err.response?.statusCode == 502);
  }

  static String handleError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return "Request to API server was cancelled";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout with API server";
      case DioExceptionType.connectionError:
        return "";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout in connection with API server";
      case DioExceptionType.sendTimeout:
        return "Send timeout in connection with API server";
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          return '';
        }
        return "Unexpected error occurred";
      case DioExceptionType.badResponse:
        return _handleError(
          dioError.response?.statusCode,
          dioError.response?.statusMessage,
        );
      default:
        return "Something went wrong";
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return "Not Found";
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  void _logResponse(Response response) {
    String responseAsString = response.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
          responseAsString.substring(i * maxCharactersPerLine, endingIndex),
        );
      }
    } else {
      debugPrint(response.data.toString());
    }
    debugPrint("<-- END HTTP");
  }

  Future<void> _redirectToHomePage() async {
    log('Current Route: ${GlobalVariableKeys.currentRouteName}');
    await SharedPref.remove(CustomStrings().token);
    await SharedPref.clear();

    /*if (GlobalVariableKeys.currentRouteName != guestHomePage &&
        GlobalVariableKeys.currentRouteName != loginPage) {
      GlobalVariableKeys.navigatorState.currentState?.pushNamedAndRemoveUntil(
        guestHomePage,
        (route) => false,
      );
    }*/
  }

  String _stringifyData(dynamic data) {
    try {
      if (data is Map || data is List) {
        return jsonEncode(data);
      } else {
        return data.toString();
      }
    } catch (e) {
      return "Failed to stringify data: $e";
    }
  }
}
