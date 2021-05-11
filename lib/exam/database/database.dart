import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final examSummaryTABLE = 'exam_summary';
final examDetailsTABLE = 'exam_details';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();

    String path = join(databasesPath, "exam.db");

    // await deleteDatabase(path);

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("Create table $examSummaryTABLE ("
        "examId INTEGER PRIMARY KEY autoincrement,"
        "score TEXT,"
        "dateTime INTEGER,"
        "examName TEXT)");

    await database.execute("Create table $examDetailsTABLE ("
        "examId INTEGER,"
        "question TEXT,"
        "answer TEXT,"
        "isCorrect INTEGER)");
  }
}
