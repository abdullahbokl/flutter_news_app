import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_theme.dart';
import 'core/shared/features/theme/presentation/theme_bloc/theme_bloc.dart';
import 'core/utils/service_locator.dart';
import 'features/news/presentation/bloc/news_bloc.dart';
import 'features/news/presentation/pages/news_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>()..add(GetTheme()),
        ),
        BlocProvider<NewsBloc>(
          create: (_) => getIt<NewsBloc>()
            ..add(GetFavoritesEvent())
            ..add(GetEveryThingEvent())
            ..add(GetTopHeadlinesEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.isDarkModeEnabled != current.isDarkModeEnabled,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode:
                state.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            home: const NewsPage(),
          );
        },
      ),
    );
  }
}
