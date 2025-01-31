part of '../bloc.dart';

final class FavouriteFetchState extends Equatable {
  final String? error;
  const FavouriteFetchState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class FavouriteFetchInitial extends FavouriteFetchState {
  const FavouriteFetchInitial();
}

final class FavouriteFetchLoading extends FavouriteFetchState {
  const FavouriteFetchLoading();
}

final class FavouriteFetchSuccess extends FavouriteFetchState {
  const FavouriteFetchSuccess();
}

final class FavouriteFetchFailure extends FavouriteFetchState {
  const FavouriteFetchFailure({
    required String error,
  }) : super(error: error);
}