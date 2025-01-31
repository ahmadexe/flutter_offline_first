part of '../bloc.dart';

final class MarkFavouriteState extends Equatable {
  final String? error;
  const MarkFavouriteState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

final class MarkFavouriteInitial extends MarkFavouriteState {
  const MarkFavouriteInitial();
}

final class MarkFavouriteLoading extends MarkFavouriteState {
  const MarkFavouriteLoading();
}

final class MarkFavouriteSuccess extends MarkFavouriteState {
  const MarkFavouriteSuccess();
}

final class MarkFavouriteFailure extends MarkFavouriteState {
  const MarkFavouriteFailure({
    required String error,
  }) : super(error: error);
}
