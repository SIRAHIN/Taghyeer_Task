import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/core/endpoints/api_endpoints.dart';
import 'package:taghyeer_task/data/api_service/user_api_service.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/products_response/products_response.dart';

@LazySingleton(as: UserApiService)
class IUserApiService extends UserApiService {
  ErrorResponse checkResponseError(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode ?? 0;
      var errorData = err.response?.data;

      // Handle empty response body \\
      if (errorData == null || errorData.toString().isEmpty) {
        return ErrorResponse(
          status: statusCode,
          message: _getDefaultMessageForStatusCode(statusCode),
        );
      }

      // Try parsing JSON response
      try {
        var errorModel = ErrorResponse.fromJson(errorData);
        return errorModel;
      } catch (e) {
        // Fallback if JSON parsing fails
        return ErrorResponse(
          status: statusCode,
          message: errorData.toString(),
        );
      }
    } else {
      return const ErrorResponse();
    }
  }

  // Mapping known server HTML error responses to user-friendly messages \\
  String _getDefaultMessageForStatusCode(int statusCode) {
    switch (statusCode) {
      case 404:
        return 'Request failed. Please check your input or try again.';
      case 408:
        return 'Request timeout. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
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
  Future<Either<ErrorResponse, ProductsResponse>> getAllProducts({required int skip}) async {
    try{
      Response response = await client.get(ApiEndpoints.getProdcutsUrl(skip: skip.toString()));
      var result = ProductsResponse.fromJson(response.data);
      return right(result);
    }on DioException catch (e) {
      return left(handleError(e));
    }
  }
}
