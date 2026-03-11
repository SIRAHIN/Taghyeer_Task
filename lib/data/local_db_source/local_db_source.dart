import 'package:taghyeer_task/domain/login_response.dart/login_response.dart';

abstract class LocalDbSource {
  Future<bool> setUserInfo({required LoginResponse userInfo});
  Future<LoginResponse?> getUserInfo();
}