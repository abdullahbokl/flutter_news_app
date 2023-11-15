import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_everything_usecases.dart';
import '../../domain/usecases/get_top_headlines_usecases.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetEveryThingUseCase getEveryThingUseCase;
  final GetTopHeadlinesUseCase getTopHeadlinesUseCase;

  // vars
  final TextEditingController searchController = TextEditingController();
  final String _country = 'us';

  NewsBloc(this.getEveryThingUseCase, this.getTopHeadlinesUseCase)
      : super(const NewsState()) {
    on<GetNewsEvent>(_getNews);
    on<GetTopHeadlinesEvent>(_getTopHeadlines);
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
}
