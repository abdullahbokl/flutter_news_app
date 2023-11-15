import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../services/api_services.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  /* API */
  // dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    )),
  );

  // API services
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(getIt()));
}
