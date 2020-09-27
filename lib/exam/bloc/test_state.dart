import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TestState extends Equatable {
  @override
  List<Object> get props => [];
}

class TestInital extends TestState {}

class TestInProgress extends TestState {
  final int duration;
  TestInProgress({@required this.duration}){
  }

  @override
  String toString() {
    return 'TestInProgress{duration: $duration}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is TestInProgress &&
          runtimeType == other.runtimeType &&
          duration == other.duration;

  @override
  int get hashCode => super.hashCode ^ duration.hashCode;
}

class TestComplete extends TestState {}

