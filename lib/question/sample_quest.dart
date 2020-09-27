import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:Bishal/question/bloc/blocks.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final ExamRepository examRepository = ExamRepository();
  TestBloc testBloc = TestBloc(examRepository);

  QuestionBloc questionBloc = QuestionBloc(examRepository);

  questionBloc
      .add(QuestionSelectedEvent());
  testBloc.add(TestStarted());
  questionBloc.add(ChangeAnswer("1000", 0));
  questionBloc.add(ChangeAnswer("10", 3));
  questionBloc.add(ChangeAnswer("140", 9));

  examRepository.questions().listen(print);

}
