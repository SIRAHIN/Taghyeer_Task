import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';
import 'package:taghyeer_task/feature/auth/domain/repository/auth_repository.dart';

@injectable
class Loginusecase {
  final AuthRepositoryContract authRepositoryContract;

  Loginusecase(this.authRepositoryContract);

  Future<Either<ErrorResponse, Login>> call({required String email, required String password}) async {
    return await authRepositoryContract.login(email, password);
  }

}