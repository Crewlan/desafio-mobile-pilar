import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_interceptor.dart';
import 'core/api/database/app_database.dart';
import 'core/api/url_creator.dart';
import 'core/device/network_info.dart';
import 'core/utils/toggle_config.dart';
import 'features/favorites/data/datasources/local/favorites_local_datasource.dart';
import 'features/favorites/data/repositories/favorites_repository.dart';
import 'features/favorites/domain/repositories/i_favorites_repository.dart';
import 'features/favorites/domain/usecases/delete_favorites.dart';
import 'features/favorites/domain/usecases/get_favorites.dart';
import 'features/favorites/domain/usecases/save_favorites.dart';
import 'features/favorites/presentation/bloc/favorite_bloc.dart';
import 'features/history/data/datasources/history_local_datasource.dart';
import 'features/history/data/repositories/history_repository.dart';
import 'features/history/domain/repositories/i_history_repository.dart';
import 'features/history/domain/usecases/delete_all_history.dart';
import 'features/history/domain/usecases/get_history.dart';
import 'features/history/domain/usecases/save_history.dart';
import 'features/history/presentation/bloc/history_bloc.dart';
import 'features/words/data/datasources/local/words_local_datasource.dart';
import 'features/words/data/datasources/remote/words_remote_datasource.dart';
import 'features/words/data/repositories/words_repository.dart';
import 'features/words/domain/repositories/i_words_repository.dart';
import 'features/words/domain/usecases/get_response_word.dart';
import 'features/words/domain/usecases/get_words_list.dart';
import 'features/words/presentation/word_bloc/word_bloc.dart';
import 'features/words/presentation/words_list_bloc/words_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<IHttpClient>(() => HttpClient());
  sl.registerLazySingleton<IUrlCreator>(() => UrlCreator());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  final remoteConfig = FirebaseRemoteConfig.instance;
  final defaults = <String, dynamic>{};
  await remoteConfig.setDefaults(defaults);
  await remoteConfig.fetch();
  await remoteConfig.activate();
  sl.registerLazySingleton<IToggleConfig>(() => ToggleConfig(remoteConfig));

  //! Feature
  //* Worlds and Word
  //* Datasource
  sl.registerLazySingleton<IWordsLocalDatasource>(() => WordsLocalDatasource(sl<AppDatabase>().wordsDao));
  sl.registerLazySingleton<IWordsRemoteDatasource>(() => WordsRemoteDatasource(sl(), sl(), sl()));

  //* Repository
  sl.registerLazySingleton<IWordsRepository>(() => WordsRepository(sl(), sl()));

  //* Usecase
  sl.registerLazySingleton(() => GetWordsList(sl()));
  sl.registerLazySingleton(() => GetResponseWord(sl()));

  //* Bloc
  sl.registerLazySingleton(() => WordsBloc(sl())); //To get offline list words
  sl.registerLazySingleton(() => WordBloc(sl())); //To Get info about word consulting the api

  //* History
  //* Datasource
  sl.registerLazySingleton<IHistoryLocalDatasource>(() => HistoryLocalDatasource(sl<AppDatabase>().historyDao));

  //* Repository
  sl.registerLazySingleton<IHistoryRepository>(() => HistoryRepository(sl()));

  //* Usecase
  sl.registerLazySingleton(() => SaveHistory(sl()));
  sl.registerLazySingleton(() => GetHistory(sl()));
  sl.registerLazySingleton(() => DeleteAllHistory(sl()));

  //* Bloc
  sl.registerLazySingleton(() => HistoryBloc(sl(), sl(), sl()));

  //* Favorites
  //* Datasource
  sl.registerLazySingleton<IFavoritesLocalDatasource>(() => FavoritesLocalDatasource(sl<AppDatabase>().favoritesDao));

  //* Repository
  sl.registerLazySingleton<IFavoritesRepository>(() => FavoritesRepository(sl()));

  //* Usecase
  sl.registerLazySingleton(() => SaveFavorites(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => DeleteFavorites(sl()));

  //* Bloc
  sl.registerLazySingleton(() => FavoritesBloc(
        sl(),
        sl(),
        sl(),
      ));

  final database = await $FloorAppDatabase.databaseBuilder('dictionary.db').addMigrations([
    AppDatabase.migration1to2,
    AppDatabase.migration2to3,
  ]).build();

  sl.registerLazySingleton<AppDatabase>(() => database);

  await sl.allReady();
}
