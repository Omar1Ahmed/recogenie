// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:recogenie/core/di/injectable_module.dart' as _i721;
import 'package:recogenie/Features/auth/data/firebase_auth_service.dart'
    as _i754;
import 'package:recogenie/Features/auth/data/repository/auth_repository_imp.dart'
    as _i287;
import 'package:recogenie/Features/auth/domain/repository/auth_repository.dart'
    as _i274;
import 'package:recogenie/Features/auth/presentation/auth_screen/logic/auth_cubit.dart'
    as _i83;
import 'package:recogenie/Features/cart/data/repository/cart_repository_imp.dart'
    as _i191;
import 'package:recogenie/Features/cart/domain/repository/cart_repository.dart'
    as _i408;
import 'package:recogenie/Features/cart/presentation/cart_screen/logic/cart_cubit.dart'
    as _i878;
import 'package:recogenie/Features/home/data/repository/home_repository_imp.dart'
    as _i955;
import 'package:recogenie/Features/home/domain/repository/home_repository.dart'
    as _i249;
import 'package:recogenie/Features/home/presentation/home_screen/logic/home_cubit.dart'
    as _i326;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => injectableModule.firebaseAuth);
    gh.lazySingleton<_i454.SupabaseClient>(
      () => injectableModule.supabaseClient,
    );
    gh.factory<_i408.CartRepository>(
      () => _i191.CartRepositoryImp(
        gh<_i454.SupabaseClient>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i249.HomeRepository>(
      () => _i955.HomeRepositoryImp(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i878.CartCubit>(
      () => _i878.CartCubit(gh<_i408.CartRepository>()),
    );
    gh.lazySingleton<_i754.FireBaseAuthService>(
      () => _i754.FireBaseAuthService(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i274.AuthRepository>(
      () => _i287.AuthRepositoryImp(gh<_i754.FireBaseAuthService>()),
    );
    gh.factory<_i326.HomeCubit>(
      () => _i326.HomeCubit(gh<_i249.HomeRepository>()),
    );
    gh.factory<_i83.AuthCubit>(
      () => _i83.AuthCubit(gh<_i274.AuthRepository>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i721.InjectableModule {}
