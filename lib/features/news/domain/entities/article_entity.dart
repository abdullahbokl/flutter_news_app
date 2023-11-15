import '../../data/models/article_model.dart';

class ArticleEntity {
  final String id;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  bool isFavorite = false;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.isFavorite = false,
  });

  factory ArticleEntity.fromModel(ArticleModel model) {
    return ArticleEntity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: model.title ?? '',
      description: model.description ?? '',
      url: model.url ?? '',
      urlToImage: model.urlToImage ?? '',
      publishedAt: model.publishedAt ?? '',
      content: model.content ?? '',
      isFavorite: false,
    );
  }
}
