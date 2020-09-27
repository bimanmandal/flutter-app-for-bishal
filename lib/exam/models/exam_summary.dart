class ExamSummary {
  final int examId;
  final String score;
  final DateTime dateTime;
  final String examName;

  ExamSummary({this.examId, this.score, this.dateTime, this.examName});

  factory ExamSummary.fromJson(Map<String, dynamic> data) =>
      new ExamSummary(
          examId:  data['examId'],
          score: data['score'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']?? 0 ),
          examName: data['examName']
      );

  Map<String, dynamic> toMap() => {
    "examId": examId,
    "score": score,
    "dateTime": dateTime.millisecondsSinceEpoch,
    "examName": examName
  };

  @override
  String toString() {
    return 'ExamSummary{examId: $examId, score: $score, dateTime: $dateTime, examName: $examName}';
  }
}