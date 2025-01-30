import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_of/models/article.dart';
import 'package:http/http.dart' as http;

part 'event.dart';
part 'state.dart';

part 'data/_remote_data_provider.dart';
part 'data/_repository.dart';
part 'data/_local_data_provider.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      final news = await _NewsRepository().getArticles();
      print(news);
    });
  }
}
