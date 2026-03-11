import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:taghyeer_task/data/local_db_source/local_db_source.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  final LocalDbSource _localDbSource;

  ThemeCubit(this._localDbSource) : super(const ThemeState.initial()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDark = await _localDbSource.getAppTheme();
    if (isDark != null && isDark) {
      emit(const ThemeState.darkMode());
    } else {
      emit(const ThemeState.lightMode());
    }
  }

  Future<void> toggleTheme() async {
    final currentIsDark = state.maybeWhen(
      darkMode: () => true,
      orElse: () => false,
    );

    final newIsDark = !currentIsDark;

    if (newIsDark) {
      emit(const ThemeState.darkMode());
    } else {
      emit(const ThemeState.lightMode());
    }

    await _localDbSource.setAppTheme(isDarkTheme: newIsDark);
  }
}
