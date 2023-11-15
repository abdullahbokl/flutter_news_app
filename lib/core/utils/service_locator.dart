import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/news/data/data_sources/local_data_source.dart';
import '../../features/news/data/data_sources/remote_data_source.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/domain/usecases/change_favorite_state_usecase.dart';
import '../../features/news/domain/usecases/get_everything_usecases.dart';
import '../../features/news/domain/usecases/get_favorites_usecases.dart';
import '../../features/news/domain/usecases/get_top_headlines_usecases.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';
import '../services/api_services.dart';
import '../services/local_db_services.dart';
import 'app_strings.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  /* Local Storage */
  getIt.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );

  getIt.registerLazySingleton<LocalDBServices>(
    () => LocalDBServices(getIt()),
  );

  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(getIt()),
  );

  /* API */
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

  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(getIt()),
  );

  /* Data Sources */
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(getIt()),
  );

  /* Repositories */
  getIt.registerLazySingleton<NewsRepo>(
    () => NewsRepoImpl(getIt(), getIt()),
  );

  /* Use Cases */
  getIt.registerLazySingleton<GetEveryThingUseCase>(
    () => GetEveryThingUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetTopHeadlinesUseCase>(
    () => GetTopHeadlinesUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(getIt()),
  );
  getIt.registerLazySingleton<ChangeFavoriteStateUseCase>(
    () => ChangeFavoriteStateUseCase(getIt()),
  );

  /* Blocs */
  getIt.registerFactory<NewsBloc>(
    () => NewsBloc(getIt(), getIt(), getIt(), getIt()),
  );
}
