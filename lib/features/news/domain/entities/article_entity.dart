import '../../data/models/article_model.dart';

class ArticleEntity {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  bool isFavorite = false;

  ArticleEntity({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.isFavorite = false,
  });

  factory ArticleEntity.fromModel(ArticleModel article) {
    return ArticleEntity(
      title: article.title ?? '',
      description: article.description ?? '',
      url: article.url ?? '',
      urlToImage: article.urlToImage ?? '',
      publishedAt: article.publishedAt ?? '',
      content: article.content ?? '',
      isFavorite: false,
    );
  }
}
