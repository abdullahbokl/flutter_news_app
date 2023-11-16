import '../../../../core/services/api_services.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/article_model.dart';
import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getNews({String? query});

  Future<List<ArticleModel>> getTopHeadlines({String? country});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiServices apiServices;

  NewsRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<ArticleModel>> getNews({
    String? query,
  }) async {
    try {
      final response = await apiServices.get(
        endPoint: AppStrings.apiEndPointEverything,
        queryParameters: {
          'q': query ?? 'everything',
        },
      );
      final List<ArticleModel> articles =
          NewsModel.fromJson(response).articles ?? [];

      return articles;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    String? country,
  }) async {
    try {
      final response = await apiServices.get(
        endPoint: AppStrings.apiEndPointTopHeadlines,
        queryParameters: {
          'country': country ?? 'us',
        },
      );
      final List<ArticleModel> articles =
          NewsModel.fromJson(response).articles ?? [];

      return articles;
    } catch (e) {
      rethrow;
    }
  }
}
