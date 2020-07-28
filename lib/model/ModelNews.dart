// To parse this JSON data, do
//
//     final modelNews = modelNewsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelNews modelNewsFromJson(String str) => ModelNews.fromJson(json.decode(str));

String modelNewsToJson(ModelNews data) => json.encode(data.toJson());

class ModelNews {
  ModelNews({
    @required this.message,
    @required this.status,
    @required this.article,
  });

  String message;
  int status;
  List<Article> article;

  factory ModelNews.fromJson(Map<String, dynamic> json) => ModelNews(
    message: json["message"],
    status: json["status"],
    article: List<Article>.from(json["article"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "article": List<dynamic>.from(article.map((x) => x.toJson())),
  };
}

class Article {
  Article({
    @required this.idNews,
    @required this.titleNews,
    @required this.imageNews,
    @required this.contentNews,
    @required this.descriptionNews,
    @required this.dateNews,
    @required this.categoryNews,
    @required this.idUser,
  });

  String idNews;
  String titleNews;
  String imageNews;
  String contentNews;
  String descriptionNews;
  DateTime dateNews;
  String categoryNews;
  String idUser;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    idNews: json["id_news"],
    titleNews: json["title_news"],
    imageNews: json["image_news"],
    contentNews: json["content_news"],
    descriptionNews: json["description_news"],
    dateNews: DateTime.parse(json["date_news"]),
    categoryNews: json["category_news"],
    idUser: json["id_user"],
  );

  Map<String, dynamic> toJson() => {
    "id_news": idNews,
    "title_news": titleNews,
    "image_news": imageNews,
    "content_news": contentNews,
    "description_news": descriptionNews,
    "date_news": "${dateNews.year.toString().padLeft(4, '0')}-${dateNews.month.toString().padLeft(2, '0')}-${dateNews.day.toString().padLeft(2, '0')}",
    "category_news": categoryNews,
    "id_user": idUser,
  };
}
