part of 'settings_cubit.dart';


@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;

  const factory SettingsState.loading() = _Loading;

  const factory SettingsState.loaded({required LoginResponse userInfo}) = _Loaded;

  const factory SettingsState.error({required ErrorResponse errorResponse}) = _Error;
}
