import 'article_model.dart';
import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    String? status,
    num? totalResults,
    List<ArticleModel>? articles,
  }) {
    _status = status;
    _totalResults = totalResults;
    _articles = articles;
  }

  NewsModel.fromJson(dynamic json) {
    _status = json['status'];
    _totalResults = json['totalResults'];
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(ArticleModel.fromJson(v));
      });
    }
  }

  String? _status;
  num? _totalResults;
  List<ArticleModel>? _articles;

  NewsModel copyWith({
    String? status,
    num? totalResults,
    List<ArticleModel>? articles,
  }) =>
      NewsModel(
        status: status ?? _status,
        totalResults: totalResults ?? _totalResults,
        articles: articles ?? _articles,
      );

  String? get status => _status;

  num? get totalResults => _totalResults;

  List<ArticleModel>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalResults'] = _totalResults;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
