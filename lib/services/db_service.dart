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
      version: 4, 
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE news(
              url TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              content TEXT NOT NULL,
              urlToImage TEXT NOT NULL
            )
        ''');

        await db.execute('''
            CREATE TABLE favourites(
              url TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              content TEXT NOT NULL,
              urlToImage TEXT NOT NULL,
              isSynced INTEGER NOT NULL DEFAULT 1
            )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS favourites(
              url TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              content TEXT NOT NULL,
              urlToImage TEXT NOT NULL,
              isSynced INTEGER NOT NULL DEFAULT 1
            )
          ''');
        }
      },
    );
  }
}