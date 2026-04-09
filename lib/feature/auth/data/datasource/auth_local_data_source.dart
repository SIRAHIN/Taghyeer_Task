import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';

abstract class AuthLocalDataSource {
  Future<bool> setUserInfo({required LoginResponse userInfo});
}

@LazySingleton(as: AuthLocalDataSource)
class IAuthLocalDataSource implements AuthLocalDataSource {
  @override
  Future<bool> setUserInfo({required LoginResponse userInfo}) async {
    try {
      final box = await Hive.openBox<LoginResponse>('user-info');
      await box.put('currentUser', userInfo);
      return true;
    } catch (error) {
      print("User Insert error: $error");
      return false;
    }
  }
}
