part of 'bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEvent extends NewsEvent {
  const FetchNewsEvent();
}

class MarkFavourite extends NewsEvent {
  final Article article;
  const MarkFavourite({
    required this.article,
  });
}

class FetchFavourites extends NewsEvent {
  const FetchFavourites();
}
