import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY,
        amount REAL,
        category TEXT,
        date TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE incomes (
        id INTEGER PRIMARY KEY,
        amount REAL,
        category TEXT,
        date TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        name TEXT,
        type TEXT
      )
    ''');
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      email TEXT UNIQUE,
      password TEXT
    )
  ''');
  }

  Future<int> insertExpense(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('expenses', row);
  }

  Future<int> insertIncome(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('incomes', row);
  }

  Future<int> insertCategory(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('categories', row);
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    Database db = await database;
    return await db.query('expenses');
  }

  Future<List<Map<String, dynamic>>> getIncomes() async {
    Database db = await database;
    return await db.query('incomes');
  }

  Future<List<Map<String, dynamic>>> getCategories(String type) async {
    Database db = await database;
    return await db.query('categories', where: 'type = ?', whereArgs: [type]);
  }

  Future<List<String>> getExpenseCategories() async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.query('categories', where: 'type = ?', whereArgs: ['expense']);
    List<String> categories = [];
    for (var map in maps) {
      categories.add(map['name']);
    }
    return categories;
  }

  Future<List<String>> getIncomeCategories() async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.query('categories', where: 'type = ?', whereArgs: ['income']);
    List<String> categories = [];
    for (var map in maps) {
      categories.add(map['name']);
    }
    return categories;
  }

  Future<int> registerUser(String email, String password) async {
    Database db = await database;

    
    List<Map<String, dynamic>> existingUsers = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingUsers.isNotEmpty) {
      throw Exception('email already exists');
    }

  
    var bytes = utf8.encode(password);
    var hash = sha256.convert(bytes);

    
    Map<String, dynamic> row = {
      'email': email,
      'password': hash.toString(),
    };

    return await db.insert('users', row);
  }

  Future<bool> loginUser(String email, String password) async {
    Database db = await database;

  
    var bytes = utf8.encode(password);
    var hash = sha256.convert(bytes);

    
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hash.toString()],
    );

    return users.isNotEmpty;
  }
}
