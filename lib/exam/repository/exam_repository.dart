import 'dart:math';

import 'package:Bishal/exam/dao/daos.dart';
import 'package:Bishal/exam/models/models.dart';
import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ExamRepository {
  List<Question> questions = List<Question>.empty(growable: true);
  String examName;

  BehaviorSubject<List<Question>> questionsStream()  {
    final subject =   BehaviorSubject<List<Question>>();
    subject.add(questions);
    return subject;
  }

  void setAnswer(int index, String answer) {
    var question = this.questions;
    question[index].providedAnswer = answer;
  }

  void reset() {
    questions = List<Question>.empty(growable: true);
  }

  String calculateScore()  {
    int totalQuestion = 0;
    int marksScored = 0;
    questions.forEach((element) {
      if (element.answer == element.providedAnswer) marksScored++;
      totalQuestion++;
    });
      return "$marksScored / $totalQuestion";
  }

  void saveToDatabase() async {
    ExamSummaryDao examSummaryDao = ExamSummaryDao();
    ExamDetailsDao examDetailsDao = ExamDetailsDao();

    DateFormat format = DateFormat("yyyyMMddHHmmss");
    int examId = int.parse(format.format(DateTime.now()));

    ExamSummary examSummary = ExamSummary(
        examId: examId,
        examName: examName,
        dateTime: DateTime.now(),
        score: calculateScore());

    List<ExamDetails> examDetails = questions.map((e) =>
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

  void generateQuestions(TestType testType, RangeValue numberRange) {
    reset();
    int start = numberRange.start.round();
    int end = numberRange.end.round();
    int numberOfQuestions = (end - start + 1 >= 10) ? 10 : end - start + 1;
    List<Question> questions = List.empty(growable: true);

    switch (testType) {
      case TestType.MULTIPICATION:
        examName = start == end
            ? "Multiplication Table of $start"
            : "Multiplication Tables from $start to $end";
        Map<String, int> multiplication =
        _genUniqueMultiplicationCombinations(start, end);
        int questionId = 1;
        multiplication.keys.forEach((key) {
          String question = "Find the multiplication of $key ? ";
          String answer = "${multiplication[key]}";
          questions.add(Question(question, answer, questionId));
          questionId ++;
        });
        break;
      case TestType.SQUARES:
        examName = start == end
            ? "Square of $start"
            : "Squares from $start to $end";
        List<int> nums =
        _genUniqueRandomNumber(start, end, numberOfQuestions);
        int questionId = 1;
        nums.forEach((number) {
          String question = "Find the square of $number ?";
          String answer = "${number * number}";
          questions.add(Question(question, answer, questionId));
          questionId ++;
        });
        break;
      case TestType.CUBE:
        examName = start == end
            ? "Cube of $start"
            : "Cubes from $start to $end";
        List<int> nums =
        _genUniqueRandomNumber(start, end, numberOfQuestions);
        int questionId = 1;
        nums.forEach((number) {
          String question = "Find the cube of $number ?";
          String answer = "${number * number * number}";
          questions.add(Question(question, answer, questionId));
          questionId ++;
        });
        break;
      case TestType.CUSTOM:
        // TODO: Handle this case.
        break;
    }

    print(questions);

    print("Questions Generated");
  }

  _genUniqueRandomNumber(int start, int end, int size) {
    var randomNumberGenerator = new Random();
    List<int> uniqueNums = List.empty(growable: true);
    if (size > end - start + 1)
      return List<int>.empty();
    else if (size == end - start + 1) {
      uniqueNums = List.generate(end - start + 1, (index) => start + index);
    } else {
      while (uniqueNums.length < size) {
        int randomNumber = start + randomNumberGenerator.nextInt(end - start);
        if (!uniqueNums.contains(randomNumber)) uniqueNums.add(randomNumber);
      }
    }
    uniqueNums.shuffle();
    return uniqueNums;
  }

  _genUniqueMultiplicationCombinations(int start, int end) {
    var randomNumberGenerator = new Random();
    Map<String, int> multiplication = Map();
    if (start == end) {
      for (int i = 1; i <= 10; i++) {
        multiplication["$start X $i"] = start * i;
      }
    }
    while (multiplication.length != 10) {
      int randomNumber = 1 + randomNumberGenerator.nextInt(10);
      int randomTable = start + randomNumberGenerator.nextInt(end - start + 1);
      String key = "$randomTable X $randomNumber";
      int value = randomTable * randomNumber;
      multiplication[key] = value;
    }
    return multiplication;
  }
}
