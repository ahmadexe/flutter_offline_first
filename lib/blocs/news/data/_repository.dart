part of '../bloc.dart';

class _NewsRepository {
  final remoteProvider = _RemoteDataProvider();

  Future<List<Article>> getArticles() async {
    try {
      final response = remoteProvider.getArticles();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}