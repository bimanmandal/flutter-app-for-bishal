
import 'package:Bishal/models/topics.dart';
import 'package:flutter/material.dart';

class InitAction {}




class ChangeRangeAction {
  final RangeValues newRange;
  ChangeRangeAction(this.newRange);
}

class SelectTopicAction {
  final TopicEnum currentTopic;
  SelectTopicAction(this.currentTopic);
}

class SubmitAnswerToQuestion {
  final int questionIndex;
  final String result;
  SubmitAnswerToQuestion(this.questionIndex, this.result);
}

class SubmitTestAction {}