import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/core/endpoints/api_endpoints.dart';

@LazySingleton()
class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}