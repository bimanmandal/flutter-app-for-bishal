class QuestionSummary {
  final int examId;
  final String score;
  final String dateTime;
  final String examName;

  QuestionSummary({this.examId, this.score, this.dateTime, this.examName});

  factory QuestionSummary.fromJson(Map<String, dynamic> data) =>
      new QuestionSummary(
        score: data['score'],
        dateTime: data['dateTime'],
        examName: data['examName']
      );

  Map<String, dynamic> toMap() => {
    "score": score,
    "dateTime": dateTime,
    "examName": examName
  };

  @override
  String toString() {
    return 'QuestionSummary{examId: $examId, score: $score, dateTime: $dateTime, examName: $examName}';
  }
}