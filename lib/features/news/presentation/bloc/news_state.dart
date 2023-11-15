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

// abstract class NewsState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// class NewsInitial extends NewsState {}
//
// class EverythingLoading extends NewsState {}
//
// class EverythingLoaded extends NewsState {
//   final List<ArticleEntity> everythingArticles;
//
//   EverythingLoaded(this.everythingArticles);
//
//   EverythingLoaded copyWith({
//     List<ArticleEntity>? everythingArticles,
//   }) {
//     return EverythingLoaded(
//       everythingArticles ?? this.everythingArticles,
//     );
//   }
//
//   @override
//   List<Object?> get props => [everythingArticles];
// }
//
// class EverythingError extends NewsState {
//   final String errorMessage;
//
//   EverythingError(this.errorMessage);
//
//   @override
//   List<Object?> get props => [errorMessage];
// }
//
// class TopHeadlinesLoading extends NewsState {}
//
// class TopHeadlinesLoaded extends NewsState {
//   final List<ArticleEntity> topHeadlinesArticles;
//
//   TopHeadlinesLoaded(this.topHeadlinesArticles);
//
//   TopHeadlinesLoaded copyWith({
//     List<ArticleEntity>? topHeadlinesArticles,
//   }) {
//     return TopHeadlinesLoaded(
//       topHeadlinesArticles ?? this.topHeadlinesArticles,
//     );
//   }
//
//   @override
//   List<Object?> get props => [topHeadlinesArticles];
// }
//
// class TopHeadlinesError extends NewsState {
//   final String errorMessage;
//
//   TopHeadlinesError(this.errorMessage);
//
//   @override
//   List<Object?> get props => [errorMessage];
// }
