import 'package:Bishal/models/question_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuestionDatabase {
  final Future<Database> _database = _createDatabase();

  static Future<Database> _createDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, "questions.db");
    return await openDatabase(dbPath, version: 2, onCreate: populateDb);
  }

  static void populateDb(Database database, int version) async {
    await database.execute("Create table question_summary ("
        "examId INTEGER PRIMARY KEY autoincrement,"
        "score TEXT,"
        "datetime STRING,"
        "examName TEXT)");

    await database.execute("Create table question_attempted ("
        "examId INTEGER,"
        "questionText TEXT,"
        "answer TEXT,"
        "isCorrect BOOLEAN)");
  }

  Future<int> insertQuestionSummary(QuestionSummary questionSummary) async {
    final Database database = await _database;
    var result = await database.insert("question_summary", questionSummary.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
    // database.close();
  }

  Future<List> getQuestionSummaries() async {
    final Database database = await _database;
    var result = await database.query("question_summary");
    return result;
    // database.close();
  }


}