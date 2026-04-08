import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/feature/auth/domain/usecase/loginUseCase.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final Loginusecase _loginusecase;
  AuthCubit(this._loginusecase) : super(const AuthState());

  // Login
  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _loginusecase(email: username, password: password);
    result.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, errorMessage: failure.message)),
      (response) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(
        isShowPassword: !state.isShowPassword,
        errorMessage: null,
        status: AuthStatus.initial));
  }
}
