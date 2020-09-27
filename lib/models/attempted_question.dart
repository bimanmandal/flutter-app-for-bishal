class AttemptedQuestion {
  final int examId;
  final String questionText;
  final String answer;
  final bool isCorrect;

  AttemptedQuestion(
      {this.examId, this.questionText, this.answer, this.isCorrect});

  factory AttemptedQuestion.fromJson(Map<String, dynamic> data) =>
      new AttemptedQuestion(
          examId: data['examId'],
          answer: data['answer'],
          isCorrect: data['isCorrect'],
          questionText: data['questionText']
      );

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "questionText" : questionText,
    "answer": answer,
    "isCorrect": isCorrect
  };
}