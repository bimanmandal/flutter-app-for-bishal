import 'package:Bishal/models/question.dart';

abstract class QuestionState{}

class InitialQuestionState extends QuestionState{}

class LoadingQuestionState extends QuestionState{}

class PopulateQuestionState extends QuestionState{
  PopulateQuestionState();
}