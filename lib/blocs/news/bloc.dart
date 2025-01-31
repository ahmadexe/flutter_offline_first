import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_of/models/article.dart';
import 'package:flutter_of/services/db_service.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'event.dart';
part 'state.dart';

part 'states/_fetch.dart';
part 'states/_favourite.dart';
part 'states/_favourite_fetch.dart';

part 'data/_remote_data_provider.dart';
part 'data/_repository.dart';
part 'data/_local_data_provider.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsInitial()) {
    on<FetchNewsEvent>(_onFetchNews);
    on<MarkFavourite>(_onMarkFavourite);
    on<FetchFavourites>(_onFetchFavourites);
  }

  final _repo = _NewsRepository();

  Future<void> _onFetchNews(
      FetchNewsEvent event, Emitter<NewsState> emit) async {
    emit(
      state.copyWith(
        fetch: const NewsFetchLoading(),
      ),
    );

    try {
      final articles = await _repo.getArticles();
      emit(
        state.copyWith(
          fetch: const NewsFetchSuccess(),
          articles: articles,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetch:
              const NewsFetchFailure(error: 'An error occurred while fetching'),
        ),
      );
    }
  }

  Future<void> _onMarkFavourite(
      MarkFavourite event, Emitter<NewsState> emit) async {
    emit(
      state.copyWith(
        favourite: const MarkFavouriteLoading(),
      ),
    );
    try {
      await _repo.markFavourite(event.article);
      emit(
        state.copyWith(
          favourite: const MarkFavouriteSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          favourite:
              const MarkFavouriteFailure(error: 'Failed to mark favourite'),
        ),
      );
    }
  }

  Future<void> _onFetchFavourites(
      FetchFavourites event, Emitter<NewsState> emit) async {
    emit(
      state.copyWith(
        fetchFavourite: const FavouriteFetchLoading(),
      ),
    );

    try {
      final favs = await _repo.getFavourites();
      emit(
        state.copyWith(
          fetchFavourite: const FavouriteFetchSuccess(),
          favourites: favs,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchFavourite: const FavouriteFetchFailure(
              error: 'An error occurred while fetching'),
        ),
      );
    }
  }
}
