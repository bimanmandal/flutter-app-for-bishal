import 'dart:async';

import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:bloc/bloc.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final ExamRepository _examRepository;
  Ticker _ticker;
  StreamSubscription<int> _tickerSubscription;

  TestBloc(this._examRepository) : super(TestInital()) {
    _ticker = Ticker();
  }

  // @override
  // void onTransition(Transition<TestEvent, TestState> transition) {
  //   print(transition);
  //   super.onTransition(transition);
  // }

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if (event is TestStarted) {
      yield* mapTestStartToState(event);
    } else if (event is TestTicked) {
      yield* mapTestTickedToState(event);
    } else if (event is TestFinished) {
      yield* mapTestFinishedToState(event);
    }
  }

  Stream<TestState> mapTestStartToState(TestStarted started) async* {
    _examRepository.questions().listen((value) {
      // int ticks = value.length * 5;
      int ticks = 10000;
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(ticks: ticks ).listen((event) {
        add(TestTicked(event));
      });
    });
  }

  Stream<TestState> mapTestTickedToState(TestTicked ticked) async* {
    if(ticked.duration > 0)
      yield TestInProgress(duration: ticked.duration);
    else add(TestFinished());
  }

  Stream<TestState> mapTestFinishedToState(TestFinished finished) async* {
    _tickerSubscription?.cancel();
    _examRepository.saveToDatabase();
    yield TestComplete();
  }

}
