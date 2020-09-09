
import 'package:flutter/material.dart';

class NumberRangeState {
  final RangeValues numberRange;

  NumberRangeState({@required this.numberRange});

  factory NumberRangeState.inital() {
    return NumberRangeState(
        numberRange: RangeValues(15, 25)
    );
  }

  NumberRangeState copyWith({RangeValues numberRange}) {
    return NumberRangeState(numberRange: numberRange ?? this.numberRange);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberRangeState &&
          runtimeType == other.runtimeType &&
          numberRange == other.numberRange;

  @override
  int get hashCode => numberRange.hashCode;
}