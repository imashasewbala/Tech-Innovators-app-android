import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../models/user.dart';
import '../models/feedback.dart'; // Ensure the correct path

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String userTable = 'user_table';
  String feedbackTable = 'feedback_table';
  String colId = 'id';
  String colFirstName = 'firstName';
  String colLastName = 'lastName';
  String colEmail = 'email';
  String colPhoneNumber = 'phoneNumber';
  String colPassword = 'password';
  String colIsVerified = 'isVerified';
  String colMessage = 'message';
  String colRating = 'rating';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, 'user.db');
      final userDatabase =
      await openDatabase(path, version: 1, onCreate: _createDb);
      return userDatabase;
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $userTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $colFirstName TEXT,
        $colLastName TEXT,
        $colEmail TEXT,
        $colPhoneNumber TEXT,
        $colPassword TEXT,
        $colIsVerified INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $feedbackTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colMessage TEXT,
        $colRating INTEGER
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    final db = await database;
    final result =
    await db.rawQuery('SELECT * FROM $userTable ORDER BY $colFirstName ASC');
    return result;
  }

  Future<int> insertUser(User user) async {
    try {
      final db = await database;
      final result = await db.insert(userTable, user.toMap());
      return result;
    } catch (e) {
      print('Error inserting user: $e');
      rethrow;
    }
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    final result = await db.update(userTable, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> getCount() async {
    final db = await database;
    final x = await db.rawQuery('SELECT COUNT (*) FROM $userTable');
    final result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<User?> getUser(String email, String password) async {
    final userMapList = await getUserMapList();
    for (int i = 0; i < userMapList.length; i++) {
      if (userMapList[i][colEmail] == email &&
          userMapList[i][colPassword] == password) {
        return User.fromMap(userMapList[i]);
      }
    }
    return null;
  }

  Future<bool> authenticateUser(String email, String password) async {
    final user = await getUser(email, password);
    return user != null;
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    final db = await database;
    int count = await db.rawUpdate(
      'UPDATE $userTable SET $colPassword = ? WHERE $colEmail = ?',
      [newPassword, email],
    );
    return count > 0;
  }

  Future<int> insertFeedback(LocalFeedback feedback) async {
    final db = await database;
    try {
      return await db.insert(feedbackTable, feedback.toMap());
    } catch (e) {
      print('Error inserting feedback: $e');
      throw e; // Rethrow the error to handle it in calling code if needed
    }
  }
}
