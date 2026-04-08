import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';

abstract class LocalSettingsDataSoruce {
    Future<LoginResponse?> getUserData();
}

@LazySingleton(as: LocalSettingsDataSoruce)
class ILocalDbSource implements LocalSettingsDataSoruce{
  @override
  Future<LoginResponse?> getUserData() async {
       try {
      final box = await Hive.openBox<LoginResponse>('user-info');
      return box.get('currentUser');
    } catch (error) {
      print("Get User error: $error");
      return null;
    }
  }

}