
import 'package:Bishal/models/question.dart';
import 'package:flutter/material.dart';

@immutable
class QuestionState {
  final int currentQuestionIndex;
  final List<NumberQuestion> questions;

  QuestionState({
    @required this.currentQuestionIndex,
    @required this.questions
  });

  factory QuestionState.initial() {
    return QuestionState(
      currentQuestionIndex: null,
      questions: List.empty()
    );
  }

  QuestionState copyWith({
    int currentQuestionIndex,
    List<NumberQuestion> questions,
  }) {
    return QuestionState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      questions: questions ?? this.questions
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionState &&
          runtimeType == other.runtimeType &&
          currentQuestionIndex == other.currentQuestionIndex &&
          questions == other.questions;

  @override
  int get hashCode => currentQuestionIndex.hashCode ^ questions.hashCode;
}

