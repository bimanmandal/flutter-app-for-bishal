import 'package:Bishal/models/formula_type.dart';
import 'package:Bishal/models/learn_type.dart';
import 'package:Bishal/screens/formula/formula_details.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FormulaHomePage extends StatelessWidget {
  final topicMap = {
    // "IX": FormulaType.IX,
    // "X": FormulaType.X,
    "XI": FormulaType.XI,
    // "XII": FormulaType.XII,
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
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormulaDetails(formulaType:topicMap[topic],),)),
              ))).toList(),
    );
  }

}