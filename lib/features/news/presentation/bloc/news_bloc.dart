import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/change_favorite_state_usecase.dart';
import '../../domain/usecases/get_everything_usecases.dart';
import '../../domain/usecases/get_favorites_usecases.dart';
import '../../domain/usecases/get_top_headlines_usecases.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsLoadedState> {
  final GetEveryThingUseCase getEveryThingUseCase;
  final GetTopHeadlinesUseCase getTopHeadlinesUseCase;

  final ChangeFavoriteStateUseCase changeFavoriteStateUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;

  // vars
  final TextEditingController searchController = TextEditingController();
  final String _country = 'us';
  Map<String, bool> _favorites = {};

  NewsBloc(
    this.getEveryThingUseCase,
    this.getTopHeadlinesUseCase,
    this.changeFavoriteStateUseCase,
    this.getFavoritesUseCase,
  ) : super(const NewsLoadedState()) {
    on<GetEveryThingEvent>(_getNews);
    on<GetTopHeadlinesEvent>(_getTopHeadlines);
    on<ChangeFavoriteStateEvent>(_changeFavoriteState);
    on<GetFavoritesEvent>(_getFavorites);
  }

  Future<FutureOr<void>> _getNews(
    GetEveryThingEvent event,
    Emitter<NewsLoadedState> emit,
  ) async {
    emit(state.copyWith(everythingRequestState: RequestState.loading));
    final String? query =
        searchController.text.isEmpty ? null : searchController.text;

    final result = await getEveryThingUseCase(NewsParams(query: query));

    List<ArticleEntity> newArticles = [];

    if (state.favoriteState == FavoriteState.loading) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    result.fold(
      (l) {
        emit(state.copyWith(
          everythingRequestState: RequestState.error,
          everythingErrorMessage: l.toString(),
        ));
      },
      (r) {
        newArticles = _handleArticles(r);
        emit(state.copyWith(
          everythingRequestState: RequestState.loaded,
          everythingArticles: newArticles,
        ));
      },
    );
  }

  Future<FutureOr<void>> _getTopHeadlines(
    GetTopHeadlinesEvent event,
    Emitter<NewsLoadedState> emit,
  ) async {
    emit(state.copyWith(topHeadlinesRequestState: RequestState.loading));
    final result =
        await getTopHeadlinesUseCase(TopHeadlinesParams(country: _country));

    List<ArticleEntity> newArticles = [];

    if (state.favoriteState == FavoriteState.loading) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    result.fold((l) {
      emit(state.copyWith(
        topHeadlinesRequestState: RequestState.error,
        topHeadlinesErrorMessage: l.toString(),
      ));
    }, (r) async {
      newArticles = _handleArticles(r);
      emit(state.copyWith(
        topHeadlinesRequestState: RequestState.loaded,
        topHeadlinesArticles: newArticles,
      ));
    });
  }

  Future<FutureOr<void>> _changeFavoriteState(
      ChangeFavoriteStateEvent event, Emitter<NewsLoadedState> emit) async {
    emit(state.copyWith(favoriteState: FavoriteState.loading));

    final String url = event.url;
    final bool isFavorite = !(_favorites[url] ?? false);
    _favorites[url] = isFavorite;

    final everyThingArticles = _handleArticles(state.everythingArticles);
    final topHeadlinesArticles = _handleArticles(state.topHeadlinesArticles);

    emit(state.copyWith(
      everythingArticles: everyThingArticles,
      topHeadlinesArticles: topHeadlinesArticles,
      favoriteState: FavoriteState.loaded,
    ));

    final result = await changeFavoriteStateUseCase(
      ChangeFavoriteStateParams(url: url),
    );
  }

  Future<FutureOr<void>> _getFavorites(
    GetFavoritesEvent event,
    Emitter<NewsLoadedState> emit,
  ) async {
    emit(state.copyWith(favoriteState: FavoriteState.loading));

    final result = await getFavoritesUseCase();

    result.fold(
      (l) {
        emit(state.copyWith(
          favoriteState: FavoriteState.error,
          everythingErrorMessage: l.toString(),
        ));
      },
      (r) {
        _favorites = r;
        emit(state.copyWith(favoriteState: FavoriteState.loaded));
      },
    );
  }

  List<ArticleEntity> _handleArticles(List<ArticleEntity> articles) {
    final List<ArticleEntity> newArticles = [];
    for (int i = 0; i < articles.length; i++) {
      final article = articles[i];
      final bool isFavorite = _favorites[article.url] ?? false;
      article.isFavorite = isFavorite;
      newArticles.add(article);
    }
    return newArticles;
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
