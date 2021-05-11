import 'dart:math';

import 'package:Bishal/models/learn_type.dart';
import 'package:flutter/material.dart';

Function _value(LearnType learnType) {
  switch (learnType) {
    case LearnType.SQUARES :
      int square(int x) {
        return x * x;
      }
      return square;
      break;
    case LearnType.CUBE :
      int cube(int x) {
        return x * x * x;
      }
      return cube;
      break;
    case LearnType.SQUAREROOT :
      String squareRoot(int x) {
        return sqrt(x).toStringAsFixed(3);
      }
      return squareRoot;
      break;
    case LearnType.CUBEROOT :
      String cubeRoot(int x) {
        return pow(x,1/3).toStringAsFixed(3);
      };
      return cubeRoot;
      break;
    case LearnType.LOGARITHMS :
      String logarithms(int x) {
        return log(x).toStringAsFixed(3);
      }
      return logarithms;
      break;
  }
}


Widget otherNumberGenratedWidget(BuildContext context, int index , LearnType learnType) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('${index + 1}', style: TextStyle(color: Theme
              .of(context)
              .accentColor),),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Text("${_value(learnType)(index + 1)}",
          style: TextStyle(fontSize: 24),
        ),
      )
    ],
  );
}

