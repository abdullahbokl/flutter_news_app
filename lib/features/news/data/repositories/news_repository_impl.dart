import 'package:dartz/dartz.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/news_local_data_source.dart';
import '../data_sources/news_remote_data_source.dart';

class NewsRepoImpl extends NewsRepo {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepoImpl(this.remoteDataSource, this.localDataSource);

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

  @override
  Future<Either<String, Map<String, bool>>> changeFavoriteState({
    String? url,
  }) async {
    try {
      final result = await localDataSource.changeFavoriteState(url);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, bool>>> getFavorites() async {
    try {
      final result = await localDataSource.getFavorites();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
