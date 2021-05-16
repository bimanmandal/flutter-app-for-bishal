import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:Bishal/question/bloc/blocks.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final ExamRepository _examRepository;

  QuestionBloc(this._examRepository) : super(InitialQuestionState());

  @override
  void onTransition(Transition<QuestionEvent, QuestionState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is QuestionSelectedEvent) {
      yield* mapQuestionSelectedEventToState(event);
    } else if (event is ChangeAnswer) {
      yield* mapChangeAnswerToState(event);
    } else if (event is InitQuestionEvent) {
      yield * mapInitQuestionEventToState(event);
    }
  }

  Stream<QuestionState> mapQuestionSelectedEventToState(QuestionSelectedEvent event) async* {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // TestType testType = TestType.values.firstWhere((element) => element.toString() == prefs.getString("test-type"));
    // final range = RangeValue(prefs.getDouble("range-start"), prefs.getDouble("range-end"));
    // _examRepository.generateQuestions(testType, range);
    yield PopulateQuestionState();
  }

  Stream<QuestionState> mapChangeAnswerToState(ChangeAnswer event) async* {
    final int index = event.index;
    final String answer = event.answer;
    _examRepository.setAnswer(index, answer);
  }

  Stream<QuestionState> mapInitQuestionEventToState(InitQuestionEvent event) async* {
    _examRepository.reset();
  }

}