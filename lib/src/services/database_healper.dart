import 'package:penny/src/models/accounts.dart';
import 'package:penny/src/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    print("_database $_database");
    // if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

   _initDatabase() async {
    // ignore: avoid_print
    print("_initDatabase");
    String path = join(await getDatabasesPath(), 'budget_app.db');
    print("path: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // Create Users table
    await db.execute('''
      CREATE TABLE Users (
        user_id INTEGER PRIMARY KEY,
        name TEXT,
        currency TEXT
      )
    ''');

    // Create Categories table
    await db.execute('''
      CREATE TABLE Categories (
        category_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        category_name TEXT,
        default_type INTEGER, 
        FOREIGN KEY (user_id) REFERENCES Users (user_id)
      )
    ''');

    // Create Accounts table
    await db.execute('''
      CREATE TABLE Accounts (
        account_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        account_name TEXT,
        account_type TEXT,   -- e.g., 'Credit', 'Debit', 'Cash'
        balance REAL DEFAULT 0.0,  -- The current balance in the account
        used INTEGER DEFAULT 0, -- 0 for unused, 1 for used
        FOREIGN KEY (user_id) REFERENCES Users (user_id)
      )
    ''');

    // Create Transactions table
    await db.execute('''
      CREATE TABLE Transactions (
        transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        category_id INTEGER,
        account_id INTEGER,  -- Added to link transactions to an account
        amount REAL,
        date TEXT,
        description TEXT,
        FOREIGN KEY (user_id) REFERENCES Users (user_id),
        FOREIGN KEY (category_id) REFERENCES Categories (category_id),
        FOREIGN KEY (account_id) REFERENCES Accounts (account_id)
      )
    ''');

    // Insert sample categories
    List<Map<String, dynamic>> sampleCategories = [
      {'user_id': 1, 'category_name': 'Food'},
      {'user_id': 1, 'category_name': 'Transport'},
      {'user_id': 1, 'category_name': 'Entertainment'},
      {'user_id': 1, 'category_name': 'Utilities'},
      {'user_id': 1, 'category_name': 'Health'},
    ];

    for (var category in sampleCategories) {
      await db.insert('Categories', category);
    }

    print("Database and tables have been created successfully with sample categories and accounts!");
  }

  // User-related methods
  Future<void> saveName(String name) async {
    final db = await database;

    var result = await db.query(
      'Users',
      where: 'user_id = ?',
      whereArgs: [1],
    );

    if (result.isNotEmpty) {
      await db.update(
        'Users',
        {'name': name},
        where: 'user_id = ?',
        whereArgs: [1],
      );
    } else {
      await db.insert(
        'Users',
        {'user_id': 1, 'name': name, 'currency': ''},
      );
    }
  }

  Future<void> saveCurrency(String? currency) async {
    final db = await database;
    db.update(
      'Users',
      {'currency': currency},
      where: 'user_id = ?',
      whereArgs: [1],
    );
  }

  Future<Map<String, dynamic>> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> data =
        await db.rawQuery("SELECT * FROM Users WHERE user_id = ?", [userId]);

    if (data.isNotEmpty) {
      return data.first;
    }
    return {};
  }

  // Future<void> createuser(String name, String currency, List<String> categories) async {
  //   final db = await database;
  //   await db.rawQuery(
  //       "insert into Users (user_id, name, currency) values (1, $name, $currency)");
  // }

  Future<int> saveUser(String name, String currency) async {
    final db = await database;

    final userId = await db.insert('users', {
      'name': name,
      'currency': currency,
    });

    print("User record added successfully with ID: $userId");
    return userId;
  }

  Future<int> updateUsername(String name, String currency) async {
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

  Future<int> updateCurrency(String name, String currency) async {
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

  // Category-related methods
  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    List<Map<String, dynamic>> categories =
        await db.rawQuery('select * from Categories where user_id = 1');
    return categories;
  }

  Future<Category> addCategory(String category) async {
    try {
      final db = await database;

      int id = await db.insert('Categories',
          {'category_name': category, 'user_id': 1, 'default_type': 0});

      print("Inserted category id: $id");

      return Category(
          categoryId: id, userId: 1, categoryName: category, defaultType: 0);
    } catch (e) {
      print("Error inserting category: $e");
      throw Exception("Failed to insert category: $e");
    }
  }

  Future<void> removeCategory(int id) async {
    print("id $id");
    try {
      final db = await database;
      int result = await db.delete(
        'Categories',
        where: 'category_id = ?',
        whereArgs: [id],
      );

      print("Deleted category id: $id, result: $result");
    } catch (e) {
      print("Error deleting category: $e");
    }
  }

  Future<void> addCategories(List<String> categories, String type) async {
    final db = await database;

    for (String category in categories) {
      await db.insert('Categories', {'category_name': category, 'user_id': 1});
    }

    print("Categories added successfully!");
  }

  Future<void> addDefaultCategories() async {
    List<String> defaultCategories = [
      'Salary',
      'Housing',
      'Fuel',
      'Food',
      'Entertainment',
      'Insurance',
      'Healthcare'
    ];

    await addCategories(defaultCategories, 'default');
  }

  // Account-related methods
  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await database;
    List<Map<String, dynamic>> accounts =
        await db.rawQuery('select * from Accounts where user_id = 1');

    print("Accounts --- $accounts");
    return accounts;
  }

  Future<int> insertAccount(Account account) async {
    final db = await database;
    return await db.insert('Accounts', account.toMap());
  }

  Future<int> updateAccount(Account account) async {
    final db = await database;
    return await db.update(
      'Accounts',
      account.toMap(),
      where: 'account_id = ?',
      whereArgs: [account.accountId],
    );
  }

  Future<int> deleteAccount(int accountId) async {
    final db = await database;
    return await db.delete(
      'Accounts',
      where: 'account_id = ?',
      whereArgs: [accountId],
    );
  }
}
