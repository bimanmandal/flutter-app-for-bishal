import 'package:flutter/material.dart';



ThemeData theme() {
  return _buildBishalAppTheme();
}

const Color blueishColor = Color(0xFF7368FF);
final orange = Color.fromARGB(255, 240, 89, 41);
final blue = Color.fromARGB(255, 33, 153, 227);


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
              color: Colors.white
          ),
          valueIndicatorColor: blueishColor
      ),
    visualDensity: VisualDensity.adaptivePlatformDensity
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

