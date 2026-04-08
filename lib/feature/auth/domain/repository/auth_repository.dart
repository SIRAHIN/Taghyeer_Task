import 'package:dartz/dartz.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';

abstract class AuthRepositoryContract {
  Future<Either<ErrorResponse, Login>> login(String email, String password);
}