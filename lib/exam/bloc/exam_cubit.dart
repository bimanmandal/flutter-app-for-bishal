import 'dart:async';

import 'package:Bishal/exam/bloc/ticker.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit(this._examRepository) :
        assert(_examRepository!= null),
        _ticker = new Ticker(),
        super(const ExamState.inital());

  final ExamRepository _examRepository;
  final Ticker _ticker;
  StreamSubscription<int> _tickerSubscription;

  Future<void> examStarted() async {
    emit(ExamState.started());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    TestType testType = TestType.values.firstWhere((element) => element.toString() == prefs.getString("test-type"));
    final range = RangeValue(prefs.getDouble("range-start"), prefs.getDouble("range-end"));
    await _examRepository.setAndgenerateQuestions(testType, range);

    final int ticks = _examRepository.questions().length * 5;
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: ticks )
            .listen((event) {
              this.examInProgress(event);
              emit(ExamState.inProgress(duration: event));});

  }

  Future<void> examInProgress(int duration) async {
      if (duration == 0) {
        _tickerSubscription?.cancel();
        await this.examEnded();
      }
  }

  Future<void> examEnded() async {
    await _tickerSubscription?.cancel();
    await _examRepository.saveToDatabase();
    emit(ExamState.ended());
  }

}