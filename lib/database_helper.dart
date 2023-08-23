import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    final databasePath = await getDatabasesPath();
    _database = await openDatabase(
      path.join(databasePath, 'my_database.db'),
      // Il percorso del database sul dispositivo.
      // Puoi utilizzare getDatabasesPath() per ottenere il percorso appropriato.

      version: 1,
      onCreate: _onCreate,
    );

    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY,
        dato0 TEXT,
        dato1 TEXT,
        dato2 TEXT,
        dato3 TEXT,
        dato4 TEXT,
        dato5 TEXT
      )
    ''');
    print(db.path);
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('my_table', data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query('my_table');
  }
}
