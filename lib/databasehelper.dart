import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static Future<Database> _openDatabase() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async{
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  static Future<int> insertUser(String name, int age) async{
    final db = await _openDatabase();
    final data = {
      'name' : name,
      'age' : age,
    };
    return await db.insert('users', data);
  }

  static Future<List<Map<String, dynamic>>> getData()async {
    final db = await _openDatabase();
    return await db.query('users');
  }

  static Future<int> deleteData(int id) async{
    final db = await _openDatabase();
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>?> getSingleData(int id) async{
    final db = await _openDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> updateData(int id, Map<String, dynamic> data) async{
    final db = await _openDatabase();
    return await db.update('users', data, where: 'id = ?', whereArgs: [id]);
  }

}