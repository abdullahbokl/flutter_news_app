part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEveryThingEvent extends NewsEvent {}

class GetTopHeadlinesEvent extends NewsEvent {}

class GetFavoritesEvent extends NewsEvent {}

class ChangeFavoriteStateEvent extends NewsEvent {
  final String id;

  ChangeFavoriteStateEvent(this.id);
}
