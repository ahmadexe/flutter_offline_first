part of 'bloc.dart';

class NewsState extends Equatable {
  final List<Article>? articles;
  final List<Article>? favourites;

  final NewsFetchState fetch;
  final MarkFavouriteState favourite;
  final FavouriteFetchState fetchFavourite;

  const NewsState({
    required this.articles,
    required this.fetch,
    required this.favourite,
    required this.fetchFavourite,
    required this.favourites,
  });

  @override
  List<Object?> get props => [
        articles,
        fetch,
        favourite,
        fetchFavourite,
        favourites,
      ];

  NewsState copyWith({
    List<Article>? articles,
    NewsFetchState? fetch,
    MarkFavouriteState? favourite,
    FavouriteFetchState? fetchFavourite,
    List<Article>? favourites,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      fetch: fetch ?? this.fetch,
      favourite: favourite ?? this.favourite,
      fetchFavourite: fetchFavourite ?? this.fetchFavourite,
      favourites: favourites ?? this.favourites,
    );
  }
}

final class NewsInitial extends NewsState {
  const NewsInitial()
      : super(
          articles: null,
          fetch: const NewsFetchInitial(),
          favourite: const MarkFavouriteInitial(),
          fetchFavourite: const FavouriteFetchInitial(),
          favourites: null,
        );
}
