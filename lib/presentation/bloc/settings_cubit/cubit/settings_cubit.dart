import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/local_db_source/local_db_source.dart';
import 'package:taghyeer_task/domain/error_response/error_response.dart';
import 'package:taghyeer_task/feature/auth/data/model/login_response.dart/login_response.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final LocalDbSource _localDbSource;
  SettingsCubit(this._localDbSource) : super(const SettingsState.initial());

  Future<void> loadUserInfo() async {
    emit(const SettingsState.loading());
    try {
      final userInfo = await _localDbSource.getUserInfo();
      if (userInfo != null) {
        emit(SettingsState.loaded(userInfo: userInfo));
      } else {
        emit(const SettingsState.error(
            errorResponse: ErrorResponse(message: "No user info found")));
      }
    } catch (e) {
      emit(SettingsState.error(
          errorResponse: ErrorResponse(message: e.toString())));
    }
  }
}
