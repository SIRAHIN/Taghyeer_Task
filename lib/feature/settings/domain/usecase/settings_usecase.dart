import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';
import 'package:taghyeer_task/feature/auth/domain/entity/login.dart';
import 'package:taghyeer_task/feature/settings/domain/repository/settings_repository_cont.dart';

@injectable
class SettingsUsecase {
  
  final SettingsRepositoryCont settingsRepositoryCont;
  SettingsUsecase(this.settingsRepositoryCont);

  Future<Either<ErrorResponse, LoginResponse>> call() async {
    return await settingsRepositoryCont.getUserData();
  }
}