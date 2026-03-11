import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/core/cache/auth_cache_manager.dart';
import 'package:taghyeer_task/core/endpoints/api_endpoints.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/login_response.dart/login_response.dart';

import 'auth_api_service.dart';

@LazySingleton(as: AuthApiService)
class IAuthApiService extends AuthApiService {
  // Generic method to check for DioException and extract error information \\
  ErrorResponse checkResponseError(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode;
      final data = err.response?.data;

      // JSON error response \\
      if (data is Map<String, dynamic>) {
        return ErrorResponse.fromJson(data);

        // Server error Response \\
      } else if (data is String) {
        return ErrorResponse(
          status: statusCode,
          message: _mapServerHtmlError(statusCode, data),
        );
      } else {
        return ErrorResponse();
      }
    } else {
      return ErrorResponse();
    }
  }

  // Mapping known server HTML error responses to user-friendly messages \\
  String _mapServerHtmlError(int? status, String body) {
    if (status == 500) {
      // Specific known backend issue
      if (body.contains('STARTTLS')) {
        return 'Service is temporarily unavailable. Please try again later.';
      }

      return 'Server error. Please try again later.';
    }

    if (status == 502 || status == 503) {
      return 'Server is down. Please try again shortly.';
    }

    return 'Status Code: $status, Client error - the request cannot be fulfilled';
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
        default:
          return checkResponseError(error);
      }
    } else if (error is SocketException) {
      return ErrorResponse(
        message: 'No internet connection. Please check your network.',
        status: 0,
      );
    } else {
      return ErrorResponse(
        message: error.toString(),
        status: 0,
      );
    }
  }

  @override
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

      return right(result);
    } on DioException catch (e) {
      return left(handleError(e));
    }
  }
}
