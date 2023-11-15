part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsEvent {}

class GetTopHeadlinesEvent extends NewsEvent {}
