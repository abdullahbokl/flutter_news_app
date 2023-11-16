import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/shared/features/theme/presentation/theme_bloc/theme_bloc.dart';
import 'core/config/app_theme.dart';
import 'core/utils/enums.dart';
import 'core/utils/service_locator.dart';
import 'features/news/presentation/bloc/news_bloc.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeBloc>()..add(GetTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.isDarkModeEnabled != current.isDarkModeEnabled,
        builder: (context, state) {
          return MaterialApp(
            title: 'News App',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode:
                state.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
            home: BlocProvider(
              create: (_) => getIt<NewsBloc>(),
              child: const NewsPage(),
            ),
          );
        },
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_4),
            onPressed: () => context.read<ThemeBloc>().add(ChangeTheme()),
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.everythingRequestState == RequestState.loading ||
              state.topHeadlinesRequestState == RequestState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.everythingRequestState == RequestState.error ||
              state.topHeadlinesRequestState == RequestState.error) {
            return Center(child: Text('Error loading news.'));
          } else {
            // Display your news articles here
            return ListView.builder(
              itemCount: state.everythingArticles.length,
              itemBuilder: (context, index) {
                final article = state.everythingArticles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  // Add more details or actions as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
