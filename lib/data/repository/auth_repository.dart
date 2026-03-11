import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/api_service/auth_api_service.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/domain/login_response.dart/login_response.dart';

abstract class AuthRepository {
  final AuthApiService authApiService;

  AuthRepository(this.authApiService);

  Future<Either<ErrorResponse, LoginResponse>> login(
      {required String userName, required String password});
}

@LazySingleton(as: AuthRepository)
class IAuthRepository extends AuthRepository {
  IAuthRepository(super.authApiService);

  @override
  Future<Either<ErrorResponse, LoginResponse>> login(
      {required String userName, required String password}) {
    return authApiService.login(userName: userName, password: password);
  }
}
