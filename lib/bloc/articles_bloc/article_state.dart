import 'package:makalam_test/model/article_responce.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {
  final List<Article> articles;

  ArticleLoading({required this.articles});
}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  final ArticleResponse articleResponse;
  final bool hasReachedMax;

  ArticleLoaded({
    required this.articles,
    required this.articleResponse,
    required this.hasReachedMax,
  });
}

class ArticleError extends ArticleState {
  final String message;

  ArticleError(this.message);
}
