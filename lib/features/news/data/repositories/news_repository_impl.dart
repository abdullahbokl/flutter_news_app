import 'package:dartz/dartz.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/remote_data_source.dart';

class NewsRepoImpl extends NewsRepo {
  final RemoteDataSource remoteDataSource;

  NewsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<ArticleEntity>>> getNews({String? query}) async {
    try {
      final result = await remoteDataSource.getNews(query: query);
      final articles = result.map((articleModel) {
        return ArticleEntity.fromModel(articleModel);
      }).toList();
      return Right(articles);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleEntity>>> getTopHeadlines(
      {String? country}) async {
    try {
      final result = await remoteDataSource.getTopHeadlines(country: country);
      final articles = result.map((articleModel) {
        return ArticleEntity.fromModel(articleModel);
      }).toList();
      return Right(articles);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
