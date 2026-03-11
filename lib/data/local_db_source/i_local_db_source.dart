import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/local_db_source/local_db_source.dart';
import 'package:taghyeer_task/domain/login_response.dart/login_response.dart';

@LazySingleton(as: LocalDbSource)
class ILocalDbSource implements LocalDbSource {
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

  @override
  Future<LoginResponse?> getUserInfo() async {
    try {
      final box = await Hive.openBox<LoginResponse>('user-info');
      return box.get('currentUser');
    } catch (error) {
      print("Get User error: $error");
      return null;
    }
  }
}
