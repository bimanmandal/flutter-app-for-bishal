import 'package:Bishal/models/topics.dart';

class InitQuestions {}

class GoToPreviousQuestionAction {}

class GoToNextQuestionAction {}

class ModifyAnswerAction {
  final String answer;
  final int index;
  ModifyAnswerAction(this.answer, this.index);
}