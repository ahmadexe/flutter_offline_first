part of '../bloc.dart';

final class NewsFetchState extends Equatable {
  final String? error;
  const NewsFetchState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class NewsFetchInitial extends NewsFetchState {
  const NewsFetchInitial();
}

final class NewsFetchLoading extends NewsFetchState {
  const NewsFetchLoading();
}

final class NewsFetchSuccess extends NewsFetchState {
  const NewsFetchSuccess();
}

final class NewsFetchFailure extends NewsFetchState {
  const NewsFetchFailure({
    required String error,
  }) : super(error: error);
}