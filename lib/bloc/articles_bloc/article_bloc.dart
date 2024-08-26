import 'package:bloc/bloc.dart';
import 'package:makalam_test/bloc/articles_bloc/article_event.dart';
import 'package:makalam_test/bloc/articles_bloc/article_state.dart';
import 'package:makalam_test/repository/articles/article_repository.dart';
import 'package:makalam_test/model/article_responce.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc(this.articleRepository) : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
  }

  Future<void> _onFetchArticles(
      FetchArticles event, Emitter<ArticleState> emit) async {
    if (state is ArticleLoading) return;

    final currentState = state;
    var oldArticles = <Article>[];
    if (currentState is ArticleLoaded) {
      oldArticles = currentState.articles;
    }

    emit(ArticleLoading(articles: oldArticles));

    try {
      final articleResponse = await articleRepository.fetchListOfArticles(
        url: (currentState is ArticleLoaded)
            ? currentState.articleResponse.next
            : null,
      );
      if (articleResponse != null) {
        final articles = oldArticles + articleResponse.results;
        emit(ArticleLoaded(
          articles: articles,
          articleResponse: articleResponse,
          hasReachedMax: articleResponse.next == null,
        ));
      } else {
        emit(ArticleError("Failed to load articles."));
      }
    } catch (e) {
      emit(ArticleError("An error occurred: $e"));
    }
  }
}
