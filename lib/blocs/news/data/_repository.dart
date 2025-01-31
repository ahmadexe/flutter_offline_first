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
    } on SocketException {
      final articles = _localProvider.getArticles();
      return articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markFavourite(Article article) async {
    try {
      await _remoteProvider.markFavourite(article);
      _localProvider.markFavourite(article);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        article = article.copyWith(
          isSynced: 0,
        );

        await _localProvider.markFavourite(article);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> getFavourites() async {
    try {
      final res = await _remoteProvider.getFavourites();
      if (res.isNotEmpty) {
        _localProvider.insertFavourites(res);
      }
      return res;
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        final favourites = await _localProvider.getFavourites();
        return favourites;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
