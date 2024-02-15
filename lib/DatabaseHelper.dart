import 'dart:io' as io;
import 'package:nested_to_sqlite/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as dbPath;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "Job4Jobless.db";
  static final _databaseVersion = 1;

  DatabaseHelper.internal();

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = dbPath.join(documentDirectory.path, _databaseName);
    return _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(User.createTable);
  }

  Future<int> saveMasterTable(var mapList, String table) async {
    var db = await database;
    int result = 0;
    for (var value in mapList) {
      result = await db!.insert(table, value);
    }
    return result;
  }

  Future<int> truncateTable(String tableName) async {
    var dbClient = await database;
    return await dbClient!.delete(tableName);
  }

  Future<int> insertData(Map<String, dynamic> mapList, String table) async {
    Database? db = await database;
    return await db!.insert(table, mapList);
  }

  Future<List<User>> getUserDatabase(String where) async {
    var db = await database;
    List<Map<String, dynamic>> resultMap = await db!.rawQuery(where);
    return resultMap.map((f) => User.fromJson(f)).toList();
  }

}
