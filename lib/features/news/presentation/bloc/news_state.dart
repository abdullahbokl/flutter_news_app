part of 'news_bloc.dart';

@immutable
class NewsLoadedState extends Equatable {
  // NewsState
  final List<ArticleEntity> everythingArticles;
  final RequestState everythingRequestState;
  final String everythingErrorMessage;

  // TopHeadlinesState
  final List<ArticleEntity> topHeadlinesArticles;
  final RequestState topHeadlinesRequestState;
  final String topHeadlinesErrorMessage;

  // favorites
  final FavoriteState favoriteState;

  const NewsLoadedState({
    this.everythingArticles = const [],
    this.everythingRequestState = RequestState.loading,
    this.everythingErrorMessage = '',
    this.topHeadlinesArticles = const [],
    this.topHeadlinesRequestState = RequestState.loading,
    this.topHeadlinesErrorMessage = '',
    this.favoriteState = FavoriteState.loading,
  });

  NewsLoadedState copyWith({
    List<ArticleEntity>? everythingArticles,
    RequestState? everythingRequestState,
    String? everythingErrorMessage,
    List<ArticleEntity>? topHeadlinesArticles,
    RequestState? topHeadlinesRequestState,
    String? topHeadlinesErrorMessage,
    FavoriteState? favoriteState,
  }) {
    return NewsLoadedState(
      everythingArticles: everythingArticles ?? this.everythingArticles,
      everythingRequestState:
          everythingRequestState ?? this.everythingRequestState,
      everythingErrorMessage:
          everythingErrorMessage ?? this.everythingErrorMessage,
      topHeadlinesArticles: topHeadlinesArticles ?? this.topHeadlinesArticles,
      topHeadlinesRequestState:
          topHeadlinesRequestState ?? this.topHeadlinesRequestState,
      topHeadlinesErrorMessage:
          topHeadlinesErrorMessage ?? this.topHeadlinesErrorMessage,
      favoriteState: favoriteState ?? this.favoriteState,
    );
  }

  @override
  List<Object?> get props => [
        everythingArticles,
        everythingRequestState,
        everythingErrorMessage,
        topHeadlinesArticles,
        topHeadlinesRequestState,
        topHeadlinesErrorMessage,
        favoriteState,
      ];
}
