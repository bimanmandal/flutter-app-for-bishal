import 'package:Bishal/models/test_type.dart';
import 'package:equatable/equatable.dart';

abstract class ExamEvent {}

class ExamInitated extends ExamEvent {}

class ExamStarted extends ExamEvent {}

class ExamQuestionPreparedEvent extends ExamEvent{}

class ExamTicked extends ExamEvent {
  final int duration;
  ExamTicked(this.duration);
}

class ExamFinished extends ExamEvent {}
