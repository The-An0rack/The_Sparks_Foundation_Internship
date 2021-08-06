import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './user.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'banking_app.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(name TEXT NOT NULL,amount DOUBLE NOT NULL, email TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  //Insert new entry to database
  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'users',
      where: "name = ?",
      whereArgs: [id],
    );
  }

  //Retrive data from database
  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
}
