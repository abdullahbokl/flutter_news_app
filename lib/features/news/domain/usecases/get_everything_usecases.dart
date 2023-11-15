import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/usecases/base_usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetEveryThingUseCase
    extends BaseUseCase<List<ArticleEntity>, NewsParams> {
  final NewsRepo newsRepo;

  GetEveryThingUseCase(this.newsRepo);

  @override
  Future<Either<String, List<ArticleEntity>>> call(
      NewsParams parameters) async {
    return await newsRepo.getNews(query: parameters.query);
  }
}

class NewsParams extends Equatable {
  final String? query;

  const NewsParams({this.query});

  @override
  List<Object?> get props => [query];
}
