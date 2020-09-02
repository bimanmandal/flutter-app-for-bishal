class Question {
  String questionText;
  bool isCorrect;

  Question.name(this.questionText, this.isCorrect);
}

class NumberQuestion {
  String questionText;
  String correctAnswer;
  String providedAnswer = "";
  bool isCorrect = false;

  NumberQuestion.set(this.questionText, this.correctAnswer);

  void setProvidedAnswer(String providedAnswer) {
    this.providedAnswer = providedAnswer;
  }

  void setIsCorrect(bool result) {
    this.isCorrect = result;
  }
  
}