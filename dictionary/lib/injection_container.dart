import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dictionary/features/home/data/datasources/home_local_datasource.dart';
import 'package:dictionary/features/home/data/repositories/home_repository.dart';
import 'package:dictionary/features/home/domain/repositories/i_home_repository.dart';
import 'package:dictionary/features/home/domain/usecases/get_worlds_list.dart';
import 'package:dictionary/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_interceptor.dart';
import 'core/api/url_creator.dart';
import 'core/device/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<IHttpClient>(() => HttpClient());
  sl.registerLazySingleton<IUrlCreator>(() => UrlCreator());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  //! Feature
  //* Home

  //* Datasource
  sl.registerLazySingleton<IHomeLocalDatasource>(() => HomeLocalDatasource());

  //* Repository
  sl.registerLazySingleton<IHomeRepository>(() => HomeRepository(sl()));

  //* Usecase
  sl.registerLazySingleton(() => GetWorldsList(sl()));

  //* Bloc
  sl.registerLazySingleton(() => HomeBloc(sl()));

  await sl.allReady();
}
