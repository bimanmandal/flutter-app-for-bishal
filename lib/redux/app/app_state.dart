import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/topics.dart';
import 'package:Bishal/redux/number_range/number_range_state.dart';
import 'package:Bishal/redux/question/question_state.dart';
import 'package:flutter/material.dart';

@immutable
class AppState {
  final QuestionState questionState;
  final TopicEnum currentTopic;
  final RangeValues numberRange;
  final String result;

  AppState({
      @required this.questionState,
      @required this.currentTopic,
      @required this.numberRange,
      @required this.result});

  factory AppState.initial() {
    return AppState(
        questionState: QuestionState.initial(),
        currentTopic: null,
        numberRange: RangeValues(15,25),
        result: null);
  }

  AppState copyWith({
      QuestionState questions,
      TopicEnum currentTopic,
      RangeValues numberRange,
      String result}) {
    return AppState(
        questionState: questions ?? this.questionState,
        currentTopic: currentTopic ?? this.currentTopic,
        numberRange: numberRange ?? this.numberRange,
        result: result ?? this.result);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          questionState == other.questionState &&
          numberRange == other.numberRange &&
          result == other.result;

  @override
  int get hashCode =>
      questionState.hashCode ^ numberRange.hashCode ^ result.hashCode;
}
