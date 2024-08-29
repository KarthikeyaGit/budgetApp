import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // ignore: avoid_print
    print("_initDatabase");
    String path = join(await getDatabasesPath(), 'budget_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Users (
      user_id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      currency TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE Categories (
      category_id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      category_name TEXT,
      FOREIGN KEY (user_id) REFERENCES Users (user_id)
    )
    ''');

    await db.execute('''
    CREATE TABLE Transactions (
      transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      category_id INTEGER,
      amount REAL,
      date TEXT,
      description TEXT,
      FOREIGN KEY (user_id) REFERENCES Users (user_id),
      FOREIGN KEY (category_id) REFERENCES Categories (category_id)
    )
    ''');

    print("Database and tables have been created successfully!");
  }

  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.rawQuery("SELECT * FROM Users WHERE user_id = ?", [userId]);
    
    if (data.isNotEmpty) {
      return data.first; 
    }
    return null; 
  }




  Future<int> saveUser(String name, String currency) async {
    final db = await database;

    final userId = await db.insert('users', {
      'name': name,
      'currency': currency,
    });

    print("User record added successfully with ID: $userId");
    return userId;
  }

  Future updateUser(int id, String name, String currency) async {
    final db = await database;

    final rowsAffected = await db.update(
      'users',
      {
        'name': name,
        'currency': currency,
      },
      where: 'user_id = ?',
      whereArgs: [id],
    );

    print("User record updated. Rows affected: $rowsAffected");
    return rowsAffected; 
  }

  Future<void> addCategories(List<String> categories) async {
    final db = await database;

    for (String category in categories) {
      await db.insert('Categories', {'category_name': category});
    }

    print("Categories added successfully!");
  }

  Future<void> addDefaultCategories() async {
    List<String> defaultCategories = [
      'Groceries',
      'Rent',
      'Utilities',
      'Transportation',
      'Entertainment'
    ];

    await addCategories(defaultCategories);
  }
}
