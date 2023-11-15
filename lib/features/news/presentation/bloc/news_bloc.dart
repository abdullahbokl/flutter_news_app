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

class NewsBloc extends Bloc<NewsEvent, NewsState> {
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
  ) : super(const NewsState()) {
    on<GetNewsEvent>(_getNews);
    on<GetTopHeadlinesEvent>(_getTopHeadlines);
    on<ChangeFavoriteStateEvent>(_changeFavoriteState);
    on<GetFavoritesEvent>(_getFavorites);
  }

  Future<FutureOr<void>> _getNews(
      GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(state.copyWith(everythingRequestState: RequestState.loading));
    final String? query =
        searchController.text.isEmpty ? null : searchController.text;

    final result = await getEveryThingUseCase(NewsParams(query: query));

    result.fold(
      (l) => emit(state.copyWith(
        everythingRequestState: RequestState.error,
        everythingErrorMessage: l.toString(),
      )),
      (r) => emit(state.copyWith(
        everythingRequestState: RequestState.loaded,
        everythingArticles: r,
      )),
    );
  }

  Future<FutureOr<void>> _getTopHeadlines(
      GetTopHeadlinesEvent event, Emitter<NewsState> emit) async {
    emit(state.copyWith(topHeadlinesRequestState: RequestState.loading));
    final result =
        await getTopHeadlinesUseCase(TopHeadlinesParams(country: _country));

    result.fold(
      (l) => emit(state.copyWith(
        topHeadlinesRequestState: RequestState.error,
        topHeadlinesErrorMessage: l.toString(),
      )),
      (r) => emit(state.copyWith(
        topHeadlinesRequestState: RequestState.loaded,
        topHeadlinesArticles: r,
      )),
    );
  }

  Future<FutureOr<void>> _changeFavoriteState(
      ChangeFavoriteStateEvent event, Emitter<NewsState> emit) async {
    final String id = event.id;
    final bool isFavorite = _favorites[id] ?? false;
    _favorites[id] = !isFavorite;

    final everyThingArticles =
        await Future.value(state.everythingArticles.map((e) {
      if (e.id == id) e.isFavorite = !isFavorite;
      return e;
    }).toList());
    final topHeadlinesArticles =
        await Future.value(state.topHeadlinesArticles.map((e) {
      if (e.id == id) e.isFavorite = !isFavorite;
      return e;
    }).toList());

    emit(state.copyWith(
      everythingArticles: everyThingArticles,
      topHeadlinesArticles: topHeadlinesArticles,
    ));

    await changeFavoriteStateUseCase(ChangeFavoriteStateParams(id: id));
  }

  Future<FutureOr<void>> _getFavorites(
      GetFavoritesEvent event, Emitter<NewsState> emit) async {
    final result = await getFavoritesUseCase();

    result.fold(
      (l) => emit(state.copyWith(
        everythingRequestState: RequestState.error,
        everythingErrorMessage: l.toString(),
      )),
      (r) async {
        _favorites = r;

        final everythingArticles = await Future.value(
          _handleIsFavorite(state.everythingArticles),
        );
        final topHeadlinesArticles = await Future.value(
          _handleIsFavorite(state.topHeadlinesArticles),
        );
        emit(state.copyWith(
          everythingArticles: everythingArticles,
          topHeadlinesArticles: topHeadlinesArticles,
        ));
      },
    );
  }

  List<ArticleEntity> _handleIsFavorite(List<ArticleEntity> articles) {
    for (ArticleEntity article in articles) {
      if (_favorites.containsKey(article.id)) {
        article.isFavorite = _favorites[article.id]!;
      } else {
        article.isFavorite = false;
      }
    }
    return articles;
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
