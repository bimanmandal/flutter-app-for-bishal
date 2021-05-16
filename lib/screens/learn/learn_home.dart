import 'package:Bishal/models/learn_type.dart';
import 'package:Bishal/screens/learn/learn_topic_details.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LearnHomePage extends StatelessWidget {
  final topicMap = {
    "Multiplication": LearnType.MULTIPLICATION,
    "Square": LearnType.SQUARES,
    "Cube": LearnType.CUBE,
    "SqurareRoot": LearnType.SQUAREROOT,
    "CubeRoot": LearnType.CUBEROOT,
    "Algebra" : LearnType.ALGEBRA,
    "Exponents" : LearnType.EXPONENTS,
    "Logarithms": LearnType.LOGARITHMS,
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: topicMap.keys.map((topic) =>
          Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Theme
                      .of(context)
                      .accentColor)),
              child: ListTile(
                leading: Icon(LineIcons.eye),
                title: Text(
                  topic,
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearnTopicDetails(learnType:topicMap[topic],),)),
              ))).toList(),
    );
  }

}
