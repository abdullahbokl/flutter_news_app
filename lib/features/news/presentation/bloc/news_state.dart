part of 'news_bloc.dart';

@immutable
class NewsState extends Equatable {
  // NewsState
  final List<ArticleEntity> everythingArticles;
  final RequestState everythingRequestState;
  final String everythingErrorMessage;

  // TopHeadlinesState
  final List<ArticleEntity> topHeadlinesArticles;
  final RequestState topHeadlinesRequestState;
  final String topHeadlinesErrorMessage;


  const NewsState({
    this.everythingArticles = const [],
    this.everythingRequestState = RequestState.loading,
    this.everythingErrorMessage = '',
    this.topHeadlinesArticles = const [],
    this.topHeadlinesRequestState = RequestState.loading,
    this.topHeadlinesErrorMessage = '',
  });

  NewsState copyWith({
    List<ArticleEntity>? everythingArticles,
    RequestState? everythingRequestState,
    String? everythingErrorMessage,
    List<ArticleEntity>? topHeadlinesArticles,
    RequestState? topHeadlinesRequestState,
    String? topHeadlinesErrorMessage,
  }) {
    return NewsState(
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
      ];
}
