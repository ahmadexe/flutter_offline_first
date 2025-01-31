part of '../bloc.dart';

class _NewsRepository {
  final _remoteProvider = _RemoteDataProvider();
  final _localProvider = _LocalDataProvider();

  Future<List<Article>> getArticles() async {
    try {
      final response = await _remoteProvider.getArticles();
      if (response.isNotEmpty) {
        _localProvider.insertArticles(response);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}