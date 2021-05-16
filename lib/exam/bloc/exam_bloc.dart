import 'dart:async';

import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:Bishal/question/bloc/blocks.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  Ticker _ticker;
  final ExamRepository _examRepository;
  StreamSubscription<int> _tickerSubscription;

  ExamBloc(this._examRepository) : super(ExamInitial()) {
    _ticker = Ticker();
    // examRepositorySubscription = questionBloc.stream.listen((state) {
    //   if (state is PopulateQuestionState){
    //     add(ExamQuestionPreparedEvent());
    //   }
    // });
  }

  @override
  void onTransition(Transition<ExamEvent, ExamState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ExamState> mapEventToState(ExamEvent event) async* {
    print(event);
    if (event is ExamStarted) {
      yield* mapTestStartToState(event);
    } else if (event is ExamTicked) {
      yield* mapTestTickedToState(event);
    } else if (event is ExamFinished) {
      yield* mapTestFinishedToState(event);
    }
  }

  Stream<ExamState> mapTestStartToState(ExamStarted examStarted) async* {
    print("Generating Questions........");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    TestType testType = TestType.values.firstWhere((element) => element.toString() == prefs.getString("test-type"));
    final range = RangeValue(prefs.getDouble("range-start"), prefs.getDouble("range-end"));
    _examRepository.generateQuestions(testType, range);
    print(await _examRepository.questionsStream().stream.length);
    final int ticks = await _examRepository.questionsStream().stream.length * 5;
    print(ticks);
    // final int ticks = 10000;
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: ticks ).listen((event) {
      add(ExamTicked(event));
    });
  }

  Stream<ExamState> mapTestTickedToState(ExamTicked ticked) async* {
    if(ticked.duration > 0)
      yield ExamInProgress(duration: ticked.duration);
    else add(ExamFinished());
  }

  Stream<ExamState> mapTestFinishedToState(ExamFinished finished) async* {
    _tickerSubscription?.cancel();
    _examRepository.saveToDatabase();
    yield ExamComplete();
  }

}
