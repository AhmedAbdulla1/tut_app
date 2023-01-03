import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final shardPref = await SharedPreferences.getInstance();
  // instance for shared pref
  instance.registerLazySingleton(() => shardPref);
  // instant for AppPreferences
  instance.registerLazySingleton(
    () => AppPreferences(
      instance<SharedPreferences>(),
    ),
  );

  // instant for network info
  instance.registerLazySingleton<NetWorkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  // instant for dioFactory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(
      instance<AppPreferences>(),
    ),
  );

  //instant for AppServicesClient
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServicesClient>(
    () => AppServicesClient(
      dio,
    ),
  );

  // instant for remoteDataSource
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      instance<AppServicesClient>(),
    ),
  );

  //instant for repository

  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance<RemoteDataSource>(),
      instance<NetWorkInfo>(),
    ),
  );

}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repository>()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(instance<LoginUseCase>()));
  }
}
initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
            () => RegisterUseCase(instance<Repository>()));
    instance.registerFactory<RegisterViewModel>(
            () => RegisterViewModel(instance<RegisterUseCase>()));
  }
}