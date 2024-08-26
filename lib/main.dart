import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makalam_test/bloc/articles_bloc/article_bloc.dart';
import 'package:makalam_test/bloc/articles_bloc/article_event.dart';
import 'package:makalam_test/repository/articles/article_repository.dart';
import 'package:makalam_test/features/main_page/article_screen.dart';

void main() {
  final Dio dio = Dio();
  final ArticleRepository articleRepository = ArticleRepository(dio: dio);

  runApp(MyApp(articleRepository: articleRepository));
}

class MyApp extends StatelessWidget {
  final ArticleRepository articleRepository;

  MyApp({required this.articleRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleBloc(articleRepository)..add(FetchArticles()),
      child: MaterialApp(
        title: 'Makalam Articles',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ArticleScreen(),
      ),
    );
  }
}
