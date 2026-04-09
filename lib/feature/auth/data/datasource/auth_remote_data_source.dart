import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/core/cache/auth_cache_manager.dart';
import 'package:taghyeer_task/core/endpoints/api_endpoints.dart';
import 'package:taghyeer_task/core/failuer/failuer.dart';
import 'package:taghyeer_task/core/network/api_client.dart';
import 'package:taghyeer_task/data/local_db_source/local_db_source.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';
import 'package:taghyeer_task/injection.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  Future<Either<ErrorResponse, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      var loginInfo = FormData.fromMap({
        'username': email,
        'password': password,
      });

      Response response = await _apiClient.post('/auth/login', data: loginInfo);

      // SAVE TOKEN
      await AuthCacheManager.setToken(token: response.data['accessToken']);

      var result = LoginResponse.fromJson(response.data);

      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
