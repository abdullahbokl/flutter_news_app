import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/usecases/base_usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlinesUseCase
    extends BaseUseCase<List<ArticleEntity>, TopHeadlinesParameters> {
  final NewsRepo newsRepo;

  GetTopHeadlinesUseCase(this.newsRepo);

  @override
  Future<Either<String, List<ArticleEntity>>> call(
      TopHeadlinesParameters parameters) async {
    return await newsRepo.getTopHeadlines(country: parameters.country);
  }
}

class TopHeadlinesParameters extends Equatable {
  final String country;

  const TopHeadlinesParameters({required this.country});

  @override
  List<Object> get props => [country];
}
