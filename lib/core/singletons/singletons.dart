// please add your imports in the imports file here if fail try to add here directly

import 'package:dio/dio.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/delete_game_usecase.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/send_message_usecase.dart';

import 'singletons_imports.dart';

final getIt = GetIt.instance;

// init request "should be init in main file before run app"
initSingletonInstances() async {
  // Register Core Components like dio client
  await registerCoreComponents();

  // Register Data Sources
  registerDataSources();

  // Register Repositories
  registerRepositoriesImp();

  // Register UseCases
  registerUseCases();

  // Register Providers
  registerProviders();
}

registerDataSources() {
  getIt.registerLazySingleton(() => GamesLocalDataSourceImp(getIt(), getIt()));
  getIt.registerLazySingleton(() => AddGameLocalDataSourceImp(getIt()));
}

registerRepositoriesImp() {
  getIt.registerLazySingleton(() => GamesRepositoryImp(getIt()));
  getIt.registerLazySingleton(() => AddGameRepositoryImp(getIt()));
}

registerUseCases() {
  getIt.registerLazySingleton(
      () => GetGamesUseCase(getIt<GamesRepositoryImp>()));
  getIt.registerLazySingleton(
      () => DeleteGameUseCase(getIt<GamesRepositoryImp>()));
  getIt.registerLazySingleton(
      () => SendMessageUseCase(getIt<GamesRepositoryImp>()));
  getIt.registerLazySingleton(
      () => AddGameUseCase(getIt<AddGameRepositoryImp>()));
}

registerProviders() {
  getIt.registerLazySingleton(() => GamesScreenProvider(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => AddGameScreenProvider(getIt()));
  getIt.registerLazySingleton(() => SettingsProvider(getIt()));
}

registerCoreComponents() async {
  // register shared perfrence
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(PrefsKeys.languageCode)) {
    prefs.setString(PrefsKeys.languageCode, 'en');
  }
  getIt.registerLazySingleton(() => prefs);

  // register dio client
  getIt.registerSingleton<Dio>(getHttpClient());

  // register local database
  getIt.registerLazySingleton<MyDatabase>(() => MyDatabase());
}

getHttpClient() {
  Dio dio = Dio(BaseOptions(
      responseType: ResponseType.json,
      validateStatus: (int? code) {
        if (code! >= 200) {
          return true;
        }
        return false;
      }));

  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, handler) async {
      return handler.reject(error);
    },
    onResponse: (response, handler) async {
      return handler.resolve(response);
    },
  ));
  //* Timeout in milliseconds for opening url. [DioErrorType.CONNECT_TIMEOUT] type
  dio.options.connectTimeout = const Duration(seconds: 30);
  //*  Timeout in milliseconds for receiving data.[DioErrorType.RECEIVE_TIMEOUT] type
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.headers['Accept'] = 'application/json';
  return dio;
}
