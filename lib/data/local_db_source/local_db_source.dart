import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';

abstract class LocalDbSource {
  Future<bool> setUserInfo({required LoginResponse userInfo});
  Future<LoginResponse?> getUserInfo();

  Future<bool> setAppTheme({required bool isDarkTheme});
  Future<bool?> getAppTheme();
}
