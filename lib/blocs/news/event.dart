part of 'bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEvent extends NewsEvent {
  const FetchNewsEvent();
}