part of '../bloc.dart';

class _LocalDataProvider {
  final String _tableName = "news";
  final String _favouritesTable = "favourites";

  Future<void> insertArticle(Article article) async {
    try {
      final db = await DbService.database;
      await db.insert(_tableName, article.toMap());
    } catch (e) {
      debugPrint('Error in insertArticle: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> markFavourite(Article article) async {
    try {
      final db = await DbService.database;
      await db.insert(_favouritesTable, article.toMap());
    } catch (e) {
      debugPrint('Error in markFavourite: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> insertFavourites(List<Article> articles) async {
    final db = await DbService.database;
    final batch = db.batch();

    for (final article in articles) {
      final data = article.toMap();
      batch.insert(
        _favouritesTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Article>> getFavourites() async {
    try {
      final db = await DbService.database;
      final result = await db.query(_favouritesTable);

      if (result.isNotEmpty) {
        return result.map((row) => Article.fromMap(row)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in getFavourites: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> insertArticles(List<Article> articles) async {
    try {
      final db = await DbService.database;
      final batch = db.batch();

      for (final article in articles) {
        final data = article.toMap();
        data.remove('isSynced');
        batch.insert(
          _tableName,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint('Error in insertArticles: ${e.toString()}');
      rethrow;
    }
  }

  Future<List<Article>> getArticles() async {
    try {
      final db = await DbService.database;

      final result = await db.query(_tableName);
      if (result.isNotEmpty) {
        return result.map((row) => Article.fromMap(row)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in getAllArticles: ${e.toString()}');
      rethrow;
    }
  }

  Future<List<Article>> getUnsyncedTasks() async {
    try {
      final db = await DbService.database;

      final result = await db.query(
        _favouritesTable,
        where: 'isSynced = ?',
        whereArgs: [0],
      );

      if (result.isNotEmpty) {
        return result.map((row) => Article.fromMap(row)).toList();
      }

      return [];
    } catch (e) {
      debugPrint('Error in getUnsyncedTasks: ${e.toString()}');
      rethrow;
    }
  }
}
