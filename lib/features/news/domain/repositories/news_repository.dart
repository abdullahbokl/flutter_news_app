import 'package:dartz/dartz.dart';

import '../entities/article_entity.dart';

abstract class NewsRepo {
  Future<Either<String, List<ArticleEntity>>> getNews({String? query});

  Future<Either<String, List<ArticleEntity>>> getTopHeadlines(
      {String? country});
}
