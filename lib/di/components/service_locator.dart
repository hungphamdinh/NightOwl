
import 'package:boilerplate/data/local/datasources/user/user_datasource.dart';
import 'package:boilerplate/data/network/apis/posts/user_api.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/module/local_module.dart';
import 'package:boilerplate/di/module/network_module.dart';
import 'package:boilerplate/stores/auth/auth_store.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/users/user_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(UserAPI(getIt<DioClient>(), getIt<RestClient>()));

  // data sources
  getIt.registerSingleton(UserDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<UserAPI>(),
    getIt<SharedPreferenceHelper>(),
    getIt<UserDataSource>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(AuthStore(getIt<Repository>()));
}
