import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/predictions.db';

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE predictions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT,
            plantName TEXT,
            disease TEXT,
            advice TEXT,
            dateTime TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPrediction(Map<String, dynamic> prediction) async {
    final db = await database;
    await db.insert('predictions', prediction);
  }

  Future<List<Map<String, dynamic>>> fetchPredictions() async {
    final db = await database;
    return db.query('predictions');
  }

  Future<void> deletePrediction(int id) async {
    final db = await database;
    await db.delete(
      'predictions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
