import 'package:Bishal/models/question.dart';

class MCQState {
  List<NumberQuestion> questions;
  List<int> numberRange;
  String result;

  MCQState({this.questions, this.numberRange});

  MCQState.fromMCQState(MCQState another) {
    this.questions = another.questions;
    this.numberRange = another.numberRange;
    this.result = another.result;
  }

  calculateResult() {
    int score = 0;
    int totalQuestion = 0;
    for (int i = 0; i < this.questions.length; i++) {
      totalQuestion += 1;
      if (this.questions[i].isCorrect) score += 1;
    }

    this.result = "$score / $totalQuestion";
  }
}