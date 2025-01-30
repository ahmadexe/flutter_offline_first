part of 'bloc.dart';

class NewsState extends Equatable {
  final List<Article>? articles;

  final NewsFetchState fetch;

  const NewsState({
    required this.articles,
    required this.fetch,
  });

  @override
  List<Object?> get props => [
        articles,
        fetch,
      ];

  NewsState copyWith({
    List<Article>? articles,
    NewsFetchState? fetch,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      fetch: fetch ?? this.fetch,
    );
  }
}

final class NewsInitial extends NewsState {
  const NewsInitial() : super(articles: null, fetch: const NewsFetchInitial());
}
