import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/Article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_articles_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_articles_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

_buildBody(BuildContext context) {
  return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (_, state) {
    if (state is RemoteArticlesLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (state is RemoteArticlesError) {
      return const Center(
        child: Icon(Icons.refresh),
      );
    }
    if (state is RemoteArticlesDone) {
      return ListView.builder(
        itemCount: state.articles!.length,
        itemBuilder: (_, index) {
          return ArticleWidget(
            article: state.articles![index],
            onArticlePressed: (article) => _onArticlePressed(context, article),
          );
        },
      );
    }

    return const SizedBox();
  });
}

void _onArticlePressed(BuildContext context, ArticleEntity article) {
  Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
}

void _onShowSavedArticlesViewTapped(BuildContext context) {
  Navigator.pushNamed(context, '/SavedArticles');
}
