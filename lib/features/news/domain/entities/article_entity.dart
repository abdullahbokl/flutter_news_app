import '../../data/models/article_model.dart';

class ArticleEntity {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  ArticleEntity({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleEntity.fromModel(ArticleModel model) {
    return ArticleEntity(
      title: model.title ?? '',
      description: model.description ?? '',
      url: model.url ?? '',
      urlToImage: model.urlToImage ?? '',
      publishedAt: model.publishedAt ?? '',
      content: model.content ?? '',
    );
  }
}
