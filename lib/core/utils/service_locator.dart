import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/news/data/data_sources/news_local_data_source.dart';
import '../../features/news/data/data_sources/news_remote_data_source.dart';
import '../../features/news/data/repositories/news_repository_impl.dart';
import '../../features/news/domain/repositories/news_repository.dart';
import '../../features/news/domain/usecases/change_favorite_state_usecase.dart';
import '../../features/news/domain/usecases/get_everything_usecases.dart';
import '../../features/news/domain/usecases/get_favorites_usecases.dart';
import '../../features/news/domain/usecases/get_top_headlines_usecases.dart';
import '../../features/news/presentation/bloc/news_bloc.dart';
import '../services/api_services.dart';
import '../services/local_db_services.dart';
import '../shared/features/theme/data/data_sources/theme_local_data_source.dart';
import '../shared/features/theme/data/repositories/theme_repositories_impl.dart';
import '../shared/features/theme/domain/repositories/theme_repositories.dart';
import '../shared/features/theme/domain/usecases/change_theme_mode_usecase.dart';
import '../shared/features/theme/domain/usecases/get_theme_mode_usecase.dart';
import '../shared/features/theme/presentation/theme_bloc/theme_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();

  /* API */
  getIt.registerLazySingleton<Dio>(
    () => ApiServices.setupDio(),
  );

  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(getIt()),
  );

  /* Local Storage */
  getIt.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );

  getIt.registerLazySingleton<LocalDBServices>(
    () => LocalDBServices(getIt()),
  );

  /* Remote Data Sources */
  getIt.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(getIt()),
  );

  /* Local Data Sources */
  getIt.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(getIt()),
  );

  /* Repositories */
  getIt.registerLazySingleton<NewsRepo>(
    () => NewsRepoImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton<ThemeRepo>(
    () => ThemeRepoImpl(getIt()),
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
  getIt.registerLazySingleton<ChangeThemeModeUseCase>(
    () => ChangeThemeModeUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetThemeModeUseCase>(
    () => GetThemeModeUseCase(getIt()),
  );

  /* Blocs */
  getIt.registerFactory<NewsBloc>(
    () => NewsBloc(getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<ThemeBloc>(
    () => ThemeBloc(getIt(), getIt()),
  );
}
