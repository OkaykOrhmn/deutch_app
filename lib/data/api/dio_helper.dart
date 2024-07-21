import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_endpoints.dart';

class DioHelper {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseURL,
    connectTimeout: const Duration(milliseconds: 30000),
    contentType: ContentType.json.toString(),
    responseType: ResponseType.json,
  ));

  DioHelper() {
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;

}
