

import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/topics.dart';
import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/redux/question/question_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class QuestionPageViewModel {
  final TopicEnum topicEnum;
  final List<NumberQuestion> questions;
  final Function previousQuestion;
  final Function nextQuestion;
  final Function(String, int) modifyAnswer;

  QuestionPageViewModel({
    @required this.topicEnum,
    @required this.questions,
    @required this.previousQuestion,
    @required this.nextQuestion,
    @required this.modifyAnswer,
  });

  static QuestionPageViewModel fromStore(Store<AppState> store) {
    return QuestionPageViewModel(
      topicEnum: store.state.currentTopic,
      questions: store.state.questionState.questions,
      previousQuestion: () {
        store.dispatch(GoToPreviousQuestionAction());
      },
      nextQuestion: () {
        store.dispatch(GoToNextQuestionAction());
      },
      modifyAnswer: (answer, index) {
        debugPrint("$answer inside modify answer in view model");
        store.dispatch(ModifyAnswerAction(answer, index));
      }
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionPageViewModel &&
          runtimeType == other.runtimeType &&
          topicEnum == other.topicEnum &&
          questions == other.questions &&
          previousQuestion == other.previousQuestion &&
          nextQuestion == other.nextQuestion &&
          modifyAnswer == other.modifyAnswer;

  @override
  int get hashCode =>
      topicEnum.hashCode ^
      questions.hashCode ^
      previousQuestion.hashCode ^
      nextQuestion.hashCode ^
      modifyAnswer.hashCode;
}