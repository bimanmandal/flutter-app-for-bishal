import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int questionId;
  final String questionText;
  final String answer;
  List<String> options = List.empty();
  String providedAnswer;

  Question(this.questionText, this.answer, this.questionId);

  Question.withOptions(this.questionId, {this.questionText, this.answer, this.options});


  @override
  String toString() {
    return 'Question{questionText: $questionText, answer: $answer, options: $options, providedAnswer: $providedAnswer}';
  }

  @override
  List<Object> get props => [questionText, answer, options, providedAnswer];
}
