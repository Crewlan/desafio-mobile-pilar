import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_interceptor.dart';
import 'core/api/url_creator.dart';
import 'core/device/network_info.dart';
import 'features/words/data/datasources/words_local_datasource.dart';
import 'features/words/data/repositories/words_repository.dart';
import 'features/words/domain/repositories/i_words_repository.dart';
import 'features/words/domain/usecases/get_words_list.dart';
import 'features/words/presentation/bloc/worlds_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<IHttpClient>(() => HttpClient());
  sl.registerLazySingleton<IUrlCreator>(() => UrlCreator());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  //! Feature
  //* Worlds

  //* Datasource
  sl.registerLazySingleton<IWordsLocalDatasource>(() => WordsLocalDatasource());

  //* Repository
  sl.registerLazySingleton<IWordsRepository>(() => WordsRepository(sl()));

  //* Usecase
  sl.registerLazySingleton(() => GetWordsList(sl()));

  //* Bloc
  sl.registerLazySingleton(() => WordsBloc(sl()));

  await sl.allReady();
}
