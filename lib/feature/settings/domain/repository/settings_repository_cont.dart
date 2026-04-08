import 'package:dartz/dartz.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';

abstract class SettingsRepositoryCont {
  Future<Either<ErrorResponse, LoginResponse>> getUserData();
}