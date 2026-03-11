// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/cache/auth_cache_manager.dart' as _i475;
import 'data/api_service/auth_api_service.dart' as _i925;
import 'data/api_service/i_auth_api_service.dart' as _i447;
import 'data/api_service/i_user_api_service.dart' as _i377;
import 'data/api_service/user_api_service.dart' as _i635;
import 'data/internet_service/internet_service.dart' as _i921;
import 'data/local_db_source/i_local_db_source.dart' as _i349;
import 'data/local_db_source/local_db_source.dart' as _i509;
import 'data/repository/auth_repository.dart' as _i691;
import 'presentation/bloc/auth_cubit/auth_cubit.dart' as _i137;
import 'presentation/bloc/internet_status_cubit/cubit/internet_status_cubit.dart'
    as _i589;
import 'presentation/bloc/posts_cubit/cubit/posts_cubit.dart' as _i928;
import 'presentation/bloc/products_cubit/cubit/products_cubit.dart' as _i568;
import 'presentation/bloc/settings_cubit/cubit/settings_cubit.dart' as _i125;
import 'presentation/bloc/theme_cubit/cubit/theme_cubit.dart' as _i840;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i475.AuthCacheManager>(() => _i475.AuthCacheManager());
  gh.lazySingleton<_i921.InternetService>(() => _i921.InternetService());
  gh.lazySingleton<_i925.AuthApiService>(() => _i447.IAuthApiService());
  gh.lazySingleton<_i509.LocalDbSource>(() => _i349.ILocalDbSource());
  gh.lazySingleton<_i635.UserApiService>(() => _i377.IUserApiService());
  gh.factory<_i125.SettingsCubit>(
      () => _i125.SettingsCubit(gh<_i509.LocalDbSource>()));
  gh.factory<_i840.ThemeCubit>(
      () => _i840.ThemeCubit(gh<_i509.LocalDbSource>()));
  gh.factory<_i589.InternetStatusCubit>(
      () => _i589.InternetStatusCubit(gh<_i921.InternetService>()));
  gh.factory<_i928.PostsCubit>(
      () => _i928.PostsCubit(gh<_i635.UserApiService>()));
  gh.factory<_i568.ProductsCubit>(
      () => _i568.ProductsCubit(gh<_i635.UserApiService>()));
  gh.lazySingleton<_i691.AuthRepository>(
      () => _i691.IAuthRepository(gh<_i925.AuthApiService>()));
  gh.factory<_i137.AuthCubit>(
      () => _i137.AuthCubit(gh<_i691.AuthRepository>()));
  return getIt;
}
