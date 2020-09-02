import 'package:Bishal/ui/App.dart';
import 'package:flutter/material.dart';

final ThemeData _appTheme = _buildBishalAppTheme();

const Color blueishColor = Color(0xFFD4D2FF);

ThemeData _buildBishalAppTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      primaryColor: blueishColor,
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      textTheme: _textTheme(base.textTheme),
      sliderTheme: SliderThemeData(
        activeTrackColor: blueishColor,
        thumbColor: blueishColor,
        valueIndicatorTextStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        valueIndicatorColor: blueishColor
      )
  );
}


TextTheme _textTheme( TextTheme base ) {
  return base.copyWith(
  ).apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
    decorationColor: Colors.black,
  );
}

void main() {
  runApp(new MaterialApp(
    theme: _appTheme,
    home: MCQApp(),
  ));
}
