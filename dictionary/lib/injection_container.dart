import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dictionary/features/history/data/datasources/history_local_datasource.dart';
import 'package:dictionary/features/history/data/repositories/history_repository.dart';
import 'package:dictionary/features/history/domain/usecases/delete_all_history.dart';
import 'package:dictionary/features/history/domain/usecases/get_history.dart';
import 'package:dictionary/features/history/domain/usecases/save_history.dart';
import 'package:dictionary/features/history/presentation/bloc/history_bloc.dart';
import 'package:dictionary/features/words/domain/usecases/delete_all_response_word.dart';
import 'package:dictionary/features/words/domain/usecases/get_response_word.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_interceptor.dart';
import 'core/api/database/app_database.dart';
import 'core/api/url_creator.dart';
import 'core/device/network_info.dart';
import 'core/utils/toggle_config.dart';
import 'features/history/domain/repositories/i_history_repository.dart';
import 'features/words/data/datasources/local/words_local_datasource.dart';
import 'features/words/data/datasources/remote/words_remote_datasource.dart';
import 'features/words/data/repositories/words_repository.dart';
import 'features/words/domain/repositories/i_words_repository.dart';
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
  sl.registerLazySingleton(() => DeleteAllResponseWord(sl()));

  //* Bloc
  sl.registerLazySingleton(() => WordsBloc(sl())); //To get offline list words
  sl.registerLazySingleton(() => WordBloc(sl(), sl())); //To Get info about word consulting the api

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

  final database = await $FloorAppDatabase.databaseBuilder('dictionary.db').addMigrations([
    AppDatabase.migration1to2,
  ]).build();

  sl.registerLazySingleton<AppDatabase>(() => database);

  await sl.allReady();
}
