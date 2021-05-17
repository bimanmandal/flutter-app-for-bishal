import 'dart:math';

import 'package:Bishal/exam/dao/daos.dart';
import 'package:Bishal/exam/models/models.dart';
import 'package:Bishal/exam/utils/question_generator.dart';
import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ExamRepository {
  List<Question> _questions;
  String _examName;
  BehaviorSubject<List<Question>> _questionStream;

  List<Question> questions() {
    return _questions;
  }

  BehaviorSubject<List<Question>> questionsStream()  {
    return _questionStream;
  }

  void setAnswer(int index, String answer) {
    this._questions[index].providedAnswer = answer;
    _questionStream.add(_questions);
  }

  Future<void> setAndgenerateQuestions(TestType testType, RangeValue rangeValue) {
    Tuple2<String, List<Question>> result = generateQuestions(testType, rangeValue);
    _examName = result.item1;
    _questions = result.item2;
    _questionStream = BehaviorSubject<List<Question>>();
    _questionStream.add(_questions);
  }

  Future<void> saveToDatabase() {
    ExamSummaryDao examSummaryDao = ExamSummaryDao();
    ExamDetailsDao examDetailsDao = ExamDetailsDao();

    DateFormat format = DateFormat("yyyyMMddHHmmss");
    int examId = int.parse(format.format(DateTime.now()));

    ExamSummary examSummary = ExamSummary(
        examId: examId,
        examName: _examName,
        dateTime: DateTime.now(),
        score: _calculateScore());

    List<ExamDetails> examDetails = _questions.map((e) =>
        ExamDetails(
            examId: examId,
            isCorrect: (e.answer == e.providedAnswer),
            answer: "${e.providedAnswer??''}",
            question: e.questionText)).toList();

    print(examSummary);
    examSummaryDao..insert(examSummary);
    examDetailsDao..insertAll(examDetails);
  }

  Stream<List<ExamSummary>> getAllSummaries() {
    ExamSummaryDao examSummaryDao = ExamSummaryDao();
    return Stream.fromFuture(examSummaryDao.getExamSummaries());
  }

  Stream<List<ExamDetails>> getExamDetails(dynamic examId) {
    ExamDetailsDao examDetailsDao = ExamDetailsDao();
    return Stream.fromFuture(examDetailsDao.getExamDetails(examId));
  }

  String _calculateScore()  {
    int totalQuestion = 0;
    int marksScored = 0;
    _questions.forEach((element) {
      if (element.answer == element.providedAnswer) marksScored++;
      totalQuestion++;
    });
    return "$marksScored / $totalQuestion";
  }

}
