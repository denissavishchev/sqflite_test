import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class NotesRepository{
  static const _dbName = 'database1.db';
  static const _tableName = 'table2';

  static Future<Database> _database() async{
    Database database = await openDatabase(
        join(await getDatabasesPath(), _dbName),
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE IF NOT EXISTS$_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, createdAt TEXT)',
          );
        },
        version: 1,
        );
    return database;
  }

  static insert({required Model model}) async{
    final db = await _database();
    await db.insert(
        _tableName,
        model.toMap(),
      // conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Model>>getData() async{
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i){
      return Model(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        createdAt: DateTime.parse(maps[i]['createdAt'])
      );
    });
  }

}