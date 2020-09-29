import 'package:Bishal/models/test_type.dart';
import 'package:equatable/equatable.dart';

abstract class TestEvent {}

class TestInitated extends TestEvent {}

class TestStarted extends TestEvent {}

class QuestionPreparedEvent extends TestEvent{}

class TestTicked extends TestEvent {
  final int duration;
  TestTicked(this.duration);
}

class TestFinished extends TestEvent {}
