
import 'package:Bishal/exam/database/database.dart';
import 'package:Bishal/exam/models/models.dart';

class ExamDetailsDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> insert(ExamDetails examDetails) async {
    final db = await dbProvider.database;
    var result = db.insert(examDetailsTABLE, examDetails.toJson());
    return result;
  }

  Future<List> insertAll(List<ExamDetails> examDetails) async {
    final db = await dbProvider.database;
    var batch = db.batch();
    examDetails.forEach((element) {
      batch.insert(examDetailsTABLE, element.toJson());
    });
    var result = batch.commit();
    return result;
  }

  //Searches if query string was passed
  Future<List<ExamDetails>> getExamDetails(dynamic query) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db
        .query(examDetailsTABLE, where: 'examId = ?', whereArgs: [query]);

    List<ExamDetails> examDetails = result.isNotEmpty
        ? result.map((item) => ExamDetails.fromJson(item)).toList()
        : [];
    return examDetails;
  }
}
