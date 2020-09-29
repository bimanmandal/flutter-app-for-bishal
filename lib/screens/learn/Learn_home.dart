import 'package:Bishal/models/learn_type.dart';
import 'package:Bishal/screens/learn/learn_topic_details.dart';
import 'package:flutter/material.dart';

class LearnHomePage extends StatelessWidget {
  final topicMap = {
    "Algebra" : LearnType.ALGEBRA,
    "Exponents" : LearnType.EXPONENTS,
    "Multiplication": LearnType.MULTIPLICATION,
    "Square": LearnType.SQUARES,
    "Cube": LearnType.CUBE,
    "SqurareRoot": LearnType.SQUAREROOT,
    "CubeRoot": LearnType.CUBEROOT,
    "Logarithms": LearnType.LOGARITHMS,
  };

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // scrollDirection: Axis.horizontal,
        crossAxisCount: 3,
        children: topicMap.keys.map((String topic) {
          return GridTile(
              child: Card(
                shadowColor: Theme.of(context).accentColor,
                margin: EdgeInsets.all(4),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LearnTopicDetails(learnType:topicMap[topic],),)),
                  child: Center(
                      child: Text(
                        topic,
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ));
        }).toList());
  }

}
