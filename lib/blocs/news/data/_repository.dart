part of '../bloc.dart';

class _NewsRepository {
  final _remoteProvider = _RemoteDataProvider();

  Future<List<Article>> getArticles() async {
    try {
      final response = _remoteProvider.getArticles();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}