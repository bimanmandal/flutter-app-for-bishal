import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ExamState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}

class ExamInProgress extends ExamState {
  final int duration;
  ExamInProgress({@required this.duration});

  @override
  String toString() {
    return 'TestInProgress{duration: $duration}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ExamInProgress &&
          runtimeType == other.runtimeType &&
          duration == other.duration;

  @override
  int get hashCode => super.hashCode ^ duration.hashCode;
}

class ExamComplete extends ExamState {}

