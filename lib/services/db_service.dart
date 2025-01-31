import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "news.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
            CREATE TABLE news(
              url TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              content TEXT NOT NULL,
              urlToImage TEXT NOT NULL
            )
      ''');
      },
    );
  }
}
