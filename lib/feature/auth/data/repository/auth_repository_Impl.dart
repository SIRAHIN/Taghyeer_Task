import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/datasource/auth_local_data_source.dart';
import 'package:taghyeer_task/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';
import 'package:taghyeer_task/feature/auth/domain/repository/auth_repository.dart';


@LazySingleton(as: AuthRepositoryContract)
class AuthRepositoryImpl extends AuthRepositoryContract {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<ErrorResponse, Login>> login(
      String email, String password) async {
    final result = await authRemoteDataSource.login(email, password);
    return result.fold(
      (failure) => Left(failure),
      (response) async {
        // SAVE USER INFO
        await authLocalDataSource.setUserInfo(userInfo: response);

        return Right(response.toEntity());
      },
    );
  }
}
