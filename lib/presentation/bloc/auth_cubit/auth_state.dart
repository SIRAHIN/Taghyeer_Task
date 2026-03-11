part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, error }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    @Default(false) bool isShowPassword,
    String? errorMessage,
  }) = _AuthState;
}