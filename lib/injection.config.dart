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
import 'data/local_db_source/i_local_db_source.dart' as _i349;
import 'data/local_db_source/local_db_source.dart' as _i509;
import 'data/repository/auth_repository.dart' as _i691;

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
  gh.lazySingleton<_i925.AuthApiService>(() => _i447.IAuthApiService());
  gh.lazySingleton<_i509.LocalDbSource>(() => _i349.ILocalDbSource());
  gh.lazySingleton<_i691.AuthRepository>(
      () => _i691.IAuthRepository(gh<_i925.AuthApiService>()));
  return getIt;
}
