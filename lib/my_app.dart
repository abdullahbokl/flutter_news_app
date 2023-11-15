import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/features/news/presentation/bloc/news_bloc.dart';

import 'core/utils/enums.dart';
import 'core/utils/service_locator.dart';
import 'features/news/data/data_sources/remote_data_source.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // dark
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      // use news bloc
      home: const AAA(),
    );
  }
}

class AAA extends StatelessWidget {
  const AAA({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewsBloc>()..add(GetNewsEvent()),
      // ..add(GetTopHeadlinesEvent()),
      lazy: false,
      child: const TestBloc(),
    );
  }
}

class TestBloc extends StatelessWidget {
  const TestBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final newsBloc = getIt<NewsBloc>();
    return Center(
      child: BlocConsumer<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state.everythingRequestState == RequestState.loaded) {
            // print("Everything is loaded ${state.everythingArticles}");
          } else if (state.everythingRequestState == RequestState.loading) {
            print("Everything is loading");
          } else if (state.everythingRequestState == RequestState.error) {
            print("Everything is error ${state.everythingErrorMessage}");
          }

          if (state.topHeadlinesRequestState == RequestState.loaded) {
            // print("TopHeadlines is loaded ${state.topHeadlinesArticles}");
          } else if (state.topHeadlinesRequestState == RequestState.loading) {
            print("TopHeadlines is loading");
          } else if (state.topHeadlinesRequestState == RequestState.error) {
            print("TopHeadlines is error");
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              newsBloc.add(GetNewsEvent());
              newsBloc.add(GetTopHeadlinesEvent());
            },
            child: Text(
              'fetch',
            ),
          );
        },
      ),
    );
  }
}
