import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makalam_test/bloc/articles_bloc/article_bloc.dart';
import 'package:makalam_test/bloc/articles_bloc/article_state.dart';
import 'package:makalam_test/bloc/articles_bloc/article_event.dart';
import 'package:makalam_test/features/main_page/article_card.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isEndOfList = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0 &&
        isEndOfList == false) {
      context.read<ArticleBloc>().add(FetchArticles());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makalam'),
        leading: const Icon(Icons.menu),
        actions: const [
          Icon(
            Icons.search,
            size: 30,
          )
        ],
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading && state.articles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.articles.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final article = state.articles[index];

                return ArticleCard(article: article);
              },
            );
          } else if (state is ArticleError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unexpected state.'));
          }
        },
      ),
    );
  }
}
