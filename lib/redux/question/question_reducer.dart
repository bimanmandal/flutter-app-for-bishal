import 'dart:math';

import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/topics.dart';
import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/redux/common/common_actions.dart';
import 'package:Bishal/redux/question/question_actions.dart';
import 'package:Bishal/redux/question/question_state.dart';
import 'package:flutter/material.dart';

QuestionState questionReducer(AppState state, dynamic action) {
  debugPrint("${action.toString()} called. I am inside questionReducer");

  if (action is GoToPreviousQuestionAction) {
    return state.questionState.copyWith(
        currentQuestionIndex: (state.questionState.currentQuestionIndex - 1) %
            state.questionState.questions.length);
  } else if (action is GoToNextQuestionAction) {
    return state.questionState.copyWith(
        currentQuestionIndex:(state.questionState.currentQuestionIndex + 1) %
            state.questionState.questions.length);
  } else if (action is ModifyAnswerAction) {
    List<NumberQuestion> questions = state.questionState.questions;
    questions[action.index].providedAnswer =
        action.answer;
    return state.questionState.copyWith(questions: questions);
  } else if (action is InitQuestions) {
    debugPrint("Init Question Triggered");
    return QuestionState(
        currentQuestionIndex: 0,
        questions: _setQuestion(state.numberRange, state.currentTopic));
  }

  return state.questionState;
}

List<NumberQuestion> _setQuestion(RangeValues numberRange, TopicEnum topic) {
  int start = numberRange.start.round();
  int end = numberRange.end.round();
  int numberOfQuestions = (end - start + 1 >= 10) ? 10 : end - start + 1;
  List<NumberQuestion> questions = List();

  switch (topic) {
    case TopicEnum.MULTIPLICATION_TABLES:
      {
        Map<String, int> multiplication =
            _genUniqueMultiplicationCombinations(start, end);
        multiplication.keys.forEach((key) {
          String question = "Find the multiplication of $key";
          String answer = "${multiplication[key]}";
          questions.add(NumberQuestion.set(question, answer));
        });
      }
      break;
    case TopicEnum.SQUARES:
      {
        List<int> nums = _genUniqueRandomNumber(start, end, numberOfQuestions);
        nums.forEach((number) {
          String question = "Find the square of $number";
          String answer = "${number * number}";
          questions.add(NumberQuestion.set(question, answer));
        });
      }
      break;
    case TopicEnum.CUBES:
      {
        List<int> nums = _genUniqueRandomNumber(start, end, numberOfQuestions);
        nums.forEach((number) {
          String question = "Find the cube of $number";
          String answer = "${number * number * number}";
          questions.add(NumberQuestion.set(question, answer));
        });
      }
      break;
  }
  return questions;
}

_genUniqueRandomNumber(int start, int end, int size) {
  var randomNumberGenerator = new Random();
  List<int> uniqueNums = List();
  if (size > end - start + 1)
    return List<int>();
  else if (size == end - start + 1) {
    uniqueNums = List.generate(end - start + 1, (index) => start + index);
  } else {
    while (uniqueNums.length < size) {
      int randomNumber = start + randomNumberGenerator.nextInt(end - start);
      if (!uniqueNums.contains(randomNumber)) uniqueNums.add(randomNumber);
    }
  }
  uniqueNums.shuffle();
  return uniqueNums;
}

_genUniqueMultiplicationCombinations(int start, int end) {
  var randomNumberGenerator = new Random();
  Map<String, int> multiplication = Map();
  if (start == end) {
    for (int i = 1; i <= 10; i++) {
      multiplication["$start X $i"] = start * i;
    }
  }
  while (multiplication.length != 10) {
    int randomNumber = 1 + randomNumberGenerator.nextInt(10);
    int randomTable = start + randomNumberGenerator.nextInt(end - start);
    String key = "$randomTable X $randomNumber";
    int value = randomTable * randomNumber;
    multiplication[key] = value;
  }
  return multiplication;
}
