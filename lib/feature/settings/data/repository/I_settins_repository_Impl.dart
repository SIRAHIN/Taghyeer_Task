import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';
import 'package:taghyeer_task/feature/settings/data/datasource/local_settings_data_soruce.dart';
import 'package:taghyeer_task/feature/settings/domain/repository/settings_repository_cont.dart';

@LazySingleton(as: SettingsRepositoryCont)
class ISettinsRepositoryImpl extends SettingsRepositoryCont {
  final LocalSettingsDataSoruce localSettingsDataSoruce;

  ISettinsRepositoryImpl(this.localSettingsDataSoruce);

  @override
  Future<Either<ErrorResponse, LoginResponse>> getUserData() async {
    try {
      final userData = await localSettingsDataSoruce.getUserData();
      if (userData != null) {
        return Right(userData);
      } else {
        return Left(ErrorResponse(message: "No user data found"));
      }
    } catch (e) {
      return Future.value(Left(ErrorResponse(message: e.toString())));
    }
  }
}
