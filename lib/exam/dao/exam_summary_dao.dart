import 'package:Bishal/exam/database/database.dart';
import 'package:Bishal/exam/models/models.dart';

class ExamSummaryDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> insert(ExamSummary examSummary) async {
    final db = await dbProvider.database;
    var result = db.insert(examSummaryTABLE, examSummary.toMap());
    return result;
  }

  //Searches if query string was passed
  Future<List<ExamSummary>> getExamSummaries({ String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(examSummaryTABLE,
            where: 'examId = ?',
            whereArgs: [query]);
    } else {
      result = await db.query(examSummaryTABLE, orderBy: "dateTime desc");
    }

    List<ExamSummary> examSummaries = result.isNotEmpty
        ? result.map((item) => ExamSummary.fromJson(item)).toList()
        : [];
    return examSummaries;
  }
}