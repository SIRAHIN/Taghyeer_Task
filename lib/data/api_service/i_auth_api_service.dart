import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/core/cache/auth_cache_manager.dart';
import 'package:taghyeer_task/core/endpoints/api_endpoints.dart';
import 'package:taghyeer_task/data/local_db_source/local_db_source.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/login_response.dart/login_response.dart';
import 'package:taghyeer_task/injection.dart';

import 'auth_api_service.dart';

@LazySingleton(as: AuthApiService)
class IAuthApiService extends AuthApiService {
  ErrorResponse checkResponseError(DioException err) {
    final statusCode = err.response?.statusCode ?? 0;
    var errorData = err.response?.data;

    // JSON error response \\
    if (errorData is Map<String, dynamic>) {
      return ErrorResponse.fromJson(errorData);

      // Server error Response \\
    } else if (errorData is String) {
      return ErrorResponse(
        status: statusCode,
        message: _getDefaultMessageForStatusCode(statusCode),
      );
    } else {
      return ErrorResponse(
        status: statusCode,
        message: 'An error occurred. Please try again.',
      );
    }
  }

  // Mapping known server HTML error responses to user-friendly messages \\
  String _getDefaultMessageForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Invalid credentials. Please try again.';
      case 403:
        return 'Access denied. Please contact support.';
      case 404:
        return 'Request failed. Please check your input or try again.';
      case 408:
        return 'Request timeout. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'Something went wrong. Please try again later.';
    }
  }

  // Helper method to handle all types of errors including timeouts \\
  ErrorResponse handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ErrorResponse(
            message: 'No internet connection. Please check your network.',
            status: 408,
          );
        case DioExceptionType.sendTimeout:
          return ErrorResponse(
            message: 'Request timeout. The server took too long to respond.',
            status: 408,
          );
        case DioExceptionType.receiveTimeout:
          return ErrorResponse(
            message:
                'Response timeout. The server is taking too long to send data.',
            status: 408,
          );
        case DioExceptionType.connectionError:
          return ErrorResponse(
            message: 'No internet connection. Please check your network.',
            status: 0,
          );
        case DioExceptionType.badResponse:
          return checkResponseError(error);
        case DioExceptionType.cancel:
          return ErrorResponse(
            message: 'Request was cancelled.',
            status: 0,
          );
        case DioExceptionType.unknown:
          return ErrorResponse(
            message: 'An unknown error occurred. Please try again.',
            status: 0,
          );
        default:
          return ErrorResponse(
            message: 'An error occurred. Please try again.',
            status: 0,
          );
      }
    } else if (error is SocketException) {
      return ErrorResponse(
        message: 'No internet connection. Please check your network.',
        status: 0,
      );
    } else {
      return ErrorResponse(
        message: 'An unexpected error occurred. Please try again.',
        status: 0,
      );
    }
  }

  @override
  Future<Either<ErrorResponse, LoginResponse>> login({
    required String userName,
    required String password,
  }) async {
    try {
      var loginInfo = FormData.fromMap({
        'username': userName,
        'password': password,
      });

      Response response =
          await client.post(ApiEndpoints.loginUrl, data: loginInfo);

      // SAVE TOKEN
      await AuthCacheManager.setToken(token: response.data['accessToken']);

      var result = LoginResponse.fromJson(response.data);

      // SAVE USER INFO
      await getIt<LocalDbSource>().setUserInfo(userInfo: result);

      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
