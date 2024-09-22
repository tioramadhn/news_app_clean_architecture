import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/Article.dart';

abstract class LocalArticlesEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticlesEvent({this.article});
  @override
  List<Object?> get props => [article!];
}

class GetSavedArticle extends LocalArticlesEvent {
  const GetSavedArticle();
}

class SaveArticle extends LocalArticlesEvent {
  const SaveArticle({required ArticleEntity article}) : super(article: article);
}

class RemoveArticle extends LocalArticlesEvent {
  const RemoveArticle({required ArticleEntity article})
      : super(article: article);
}
