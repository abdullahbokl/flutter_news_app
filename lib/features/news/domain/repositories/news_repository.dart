import 'package:dartz/dartz.dart';

import '../entities/article_entity.dart';

abstract class NewsRepo {
  // remote data source
  Future<Either<String, List<ArticleEntity>>> getNews({String? query});

  Future<Either<String, List<ArticleEntity>>> getTopHeadlines({
    String? country,
  });

  // local data source
  Future<Either<String, Map<String, bool>>> changeFavoriteState({String? id});

  Future<Either<String, Map<String, bool>>> getFavorites();
}
