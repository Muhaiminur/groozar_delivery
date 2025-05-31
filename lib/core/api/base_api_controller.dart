import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utility/customStrings.dart';
import 'api_url.dart';
import 'interceptor.dart';

class BaseApiController {
  Dio? _dio = Dio();

  BaseApiController._();

  static final instance = BaseApiController._();

  BaseApiController() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 60 * 1000),
      headers: {CustomStrings().contentType: CustomStrings().contentTypeValue},
    );

    _dio =
        Dio(dioOptions)
          ..interceptors.add(AppInterceptors(dio: getDio()!))
          ..interceptors.add(PrettyDioLogger());
  }

  Dio? getDio() => _dio;
}
