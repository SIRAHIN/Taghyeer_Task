import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';
import 'package:taghyeer_task/feature/auth/domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepositoryContract)
class AuthRepositoryImpl extends AuthRepositoryContract{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<ErrorResponse, Login>> login(String email, String password) => authRemoteDataSource.login(email, password);

}