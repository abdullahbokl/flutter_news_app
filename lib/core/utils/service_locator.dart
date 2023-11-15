import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../services/api_services.dart';
import 'app_strings.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  /* API */
  // dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: AppStrings.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    )),
  );

  // API services
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(getIt()));
}
