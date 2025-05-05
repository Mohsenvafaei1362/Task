// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:testproject/core/local_storage/save_todo.dart' as _i197;
import 'package:testproject/core/network/dio_logger_interceptor.dart' as _i430;
import 'package:testproject/core/network/network_info.dart' as _i939;
import 'package:testproject/core/network/network_module.dart' as _i817;
import 'package:testproject/core/network/service/api_client.dart' as _i987;
import 'package:testproject/features/login/data/datasource/login_repository_impl.dart'
    as _i873;
import 'package:testproject/features/login/domain/ripository/login_repository.dart'
    as _i860;
import 'package:testproject/features/login/domain/usecase/login_usecase.dart'
    as _i76;
import 'package:testproject/features/login/presentation/bloc/login_bloc.dart'
    as _i948;
import 'package:testproject/features/register/data/datasource/register_repository_impl.dart'
    as _i669;
import 'package:testproject/features/register/domain/ripository/register_repository.dart'
    as _i781;
import 'package:testproject/features/register/domain/usecase/register_usecase.dart'
    as _i800;
import 'package:testproject/features/register/presentation/bloc/register_bloc.dart'
    as _i651;
import 'package:testproject/features/todo_list/presentation/bloc/todo_bloc.dart'
    as _i460;

const String _mock = 'mock';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i939.NetworkInfo>(() => _i939.NetworkInfoImpl());
    gh.lazySingleton<_i430.DioLoggerInterceptor>(
      () => _i430.DioLoggerInterceptorMockImpl(),
      registerFor: {_mock, _dev},
    );
    gh.lazySingleton<_i197.ToDoPreferences>(() => _i197.ToDoPreferencesImpl());
    gh.factory<_i460.TodoBloc>(
      () => _i460.TodoBloc(gh<_i197.ToDoPreferences>()),
    );
    gh.lazySingleton<_i430.DioLoggerInterceptor>(
      () => _i430.DioLoggerInterceptorImpl(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i430.DioLoggerInterceptor>()),
    );
    gh.lazySingleton<_i987.ApiClient>(
      () => networkModule.apiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i781.RegisterRepository>(
      () => _i669.RegisterRepositoryImpl(
        gh<_i939.NetworkInfo>(),
        gh<_i987.ApiClient>(),
      ),
      registerFor: {_dev, _prod},
    );
    gh.lazySingleton<_i860.LoginRepository>(
      () => _i873.LoginRepositoryImpl(
        gh<_i939.NetworkInfo>(),
        gh<_i987.ApiClient>(),
      ),
      registerFor: {_dev, _prod},
    );
    gh.singleton<_i800.RegisterUsecase>(
      () => _i800.RegisterUsecase(gh<_i781.RegisterRepository>()),
    );
    gh.singleton<_i76.LoginUsecase>(
      () => _i76.LoginUsecase(gh<_i860.LoginRepository>()),
    );
    gh.factory<_i948.LoginBloc>(() => _i948.LoginBloc(gh<_i76.LoginUsecase>()));
    gh.factory<_i651.RegisterBloc>(
      () => _i651.RegisterBloc(gh<_i800.RegisterUsecase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i817.NetworkModule {}
