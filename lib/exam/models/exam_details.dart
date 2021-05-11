class ExamDetails {
  final int examId;
  final String question;
  final String answer;
  final bool isCorrect;

  ExamDetails({this.examId, this.question, this.answer, this.isCorrect});

  factory ExamDetails.fromJson(Map<String, dynamic> data) =>
      new ExamDetails(
          examId: data['examId'],
          question: data['question'],
          answer: data['answer'],
          isCorrect: data['isCorrect'] == 0 ? false : true ,
      );

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "question" : question,
    "answer": answer ,
    "isCorrect": isCorrect == false ? 0 : 1,
  };

  @override
  String toString() {
    return 'ExamDetails{examId: $examId, question: $question, answer: $answer, isCorrect: $isCorrect}';
  }
}