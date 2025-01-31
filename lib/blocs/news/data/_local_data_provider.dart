part of '../bloc.dart';

class _LocalDataProvider {
  final String _tableName = "news";

  Future<void> insertArticle(Article article) async {
    try {
      final db = await DbService.database;
      await db.insert(_tableName, article.toMap());
    } catch (e) {
      debugPrint('Error in insertArticle: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> insertArticles(List<Article> articles) async {
    try {
      final db = await DbService.database;
      final batch = db.batch();

      for (final article in articles) {
        batch.insert(
          _tableName,
          article.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    } catch (e) {
      debugPrint('Error in insertArticles: ${e.toString()}');
      rethrow;
    }
  }

  Future<List<Article>> getAllArticles() async {
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
        _tableName,
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

  Future<void> updateRowValue(String url, int newValue) async {
    try {
      final db = await DbService.database;
      await db.update(
        _tableName,
        {'isSynced': newValue},
        where: 'url = ?',
        whereArgs: [url],
      );
    } catch (e) {
      debugPrint('Error in updateRowValue: $e');
      rethrow;
    }
  }
}
