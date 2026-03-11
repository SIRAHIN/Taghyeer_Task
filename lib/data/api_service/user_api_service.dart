import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taghyeer_task/core/cache/auth_cache_manager.dart';
import 'package:taghyeer_task/core/endpoints/api_endpoints.dart';
import 'package:taghyeer_task/core/router/route_manager.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/products_response/products_response.dart';


abstract class UserApiService {
  UserApiService() {
    client.interceptors.addAll([
      InterceptorsWrapper(onRequest: (options, handler) async {
        String? token = await AuthCacheManager.getToken();
        options.headers["Accept"] = "application/json";
        options.headers["Authorization"] = "Bearer $token";
        return handler.next(options);
      }, onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle 401 error, redirect to login
          AuthCacheManager.signOut();
          RouteManager.router.goNamed(loginViewName);  
        }
        return handler.next(error);
      }),

      // Logging interceptor //
      AwesomeDioInterceptor(
        // Disabling headers and timeout would minimize the logging output.
        // Optional, defaults to true
        logRequestTimeout: false,
        logRequestHeaders: true,
        logResponseHeaders: true,

        // Optional, defaults to the 'log' function in the 'dart:developer' package.
        logger: debugPrint,
      ),
    ]);

  }


  Dio client = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
    responseType: ResponseType.json,
    contentType: "application/json",
  ));


  // Get All Products \ 
  Future<Either<ErrorResponse, ProductsResponse>> getAllProducts({required int skip});
}
