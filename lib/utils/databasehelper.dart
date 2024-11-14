import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        preparationTime TEXT,
        ingredients TEXT,
        description TEXT,
        user TEXT,
        publicationTime TEXT
        image TEXT
      )
    ''');
  }

  Future<int> insertRecipe(Map<String, dynamic> recipe) async {
    Database db = await database;
    return await db.insert('recipes', recipe);
  }

  Future<List<Map<String, dynamic>>> getRecipes() async {
    Database db = await database;
    return await db.query('recipes');
  }

  Future<int> updateRecipe(Map<String, dynamic> recipe) async {
    Database db = await database;
    int id = recipe['id'];
    return await db.update('recipes', recipe, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRecipe(int id) async {
    Database db = await database;
    return await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }
}