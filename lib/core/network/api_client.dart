import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/core/network/dio_client.dart';

@LazySingleton()
class ApiClient {
  final DioClient dioClient;

  ApiClient(this.dioClient);

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) {
    return dioClient.dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) {
    return dioClient.dio.post(path, data: data);
  }
}