import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';

abstract class QuestionEvent {}

class InitQuestionEvent extends QuestionEvent{}

class QuestionSelectedEvent extends QuestionEvent{
}

class ChangeAnswer extends QuestionEvent{
  final String answer;
  final int index;

  ChangeAnswer(this.answer, this.index);

  @override
  String toString() {
    return 'ChangeAnswer{answer: $answer, index: $index}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeAnswer &&
          runtimeType == other.runtimeType &&
          answer == other.answer &&
          index == other.index;

  @override
  int get hashCode => answer.hashCode ^ index.hashCode;
}

class QuestionCleanupEvent extends QuestionEvent{}