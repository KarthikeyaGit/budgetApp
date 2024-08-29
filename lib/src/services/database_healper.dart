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
    user_id INTEGER PRIMARY KEY,
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

  // Insert sample categories
  List<Map<String, dynamic>> sampleCategories = [
    {'user_id': null, 'category_name': 'Food'},
    {'user_id': null, 'category_name': 'Transport'},
    {'user_id': null, 'category_name': 'Entertainment'},
    {'user_id': null, 'category_name': 'Utilities'},
    {'user_id': null, 'category_name': 'Health'},
  ];

  for (var category in sampleCategories) {
    await db.insert('Categories', category);
  }

  print("Database and tables have been created successfully with sample categories!");
}


  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> data =
        await db.rawQuery("SELECT * FROM Users WHERE user_id = ?", [userId]);

    if (data.isNotEmpty) {
      return data.first;
    }
    return null;
  }

  Future createuser(
      String name, String currency, List<String> categories) async {
    final db = await database;
     await db.rawQuery(
        "insert into Users (user_id, name, currency) values (1, $name, $currency)");
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

  Future updateUsername(String name, String currency) async {
    final db = await database;

    final rowsAffected = await db.update(
      'users',
      {
        'name': name,
      },
      where: 'user_id = ?',
      whereArgs: [1],
    );

    print("User record updated. Rows affected: $rowsAffected");
    return rowsAffected;
  }

    Future updateCurrency(String name, String currency) async {
    final db = await database;

    final rowsAffected = await db.update(
      'users',
      {
        'currency': currency,
      },
      where: 'user_id = ?',
      whereArgs: [1],
    );

    print("User record updated. Rows affected: $rowsAffected");
    return rowsAffected;
  }

  Future<void> addCategories(List<String> categories, String type) async {
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

    await addCategories(defaultCategories, 'default');
  }
}
