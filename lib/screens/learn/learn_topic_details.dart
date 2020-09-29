import 'dart:math';

import 'package:Bishal/common/app_bar.dart';
import 'package:Bishal/models/learn_type.dart';
import 'package:Bishal/screens/learn/widgets/algebra.dart';
import 'package:Bishal/screens/learn/widgets/multiplication_widget.dart';
import 'package:Bishal/screens/learn/widgets/other_number.dart';
import 'package:flutter/material.dart';

class LearnTopicDetails extends StatelessWidget {
  final LearnType learnType;

  const LearnTopicDetails({Key key, this.learnType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BishalAppBar(),
      body: (((){
        switch (learnType) {
          case LearnType.ALGEBRA :
            return FormulaWidget(formulaPath: "assets/formulas/algebra.json",);
            break;
          case LearnType.EXPONENTS :
            return FormulaWidget(formulaPath: "assets/formulas/exponents.json",);
            break;
          default:
            return GridView.count(
              crossAxisCount: 3,
              children: List.generate(100, (index) {
                return GridTile(
                  child: Card(
                    shadowColor: Theme
                        .of(context)
                        .accentColor,
                    margin: EdgeInsets.all(4),
                    child: learnType == LearnType.MULTIPLICATION
                            ? multiplicationWidget(context, index)
                            : otherNumberGenratedWidget(context, index, learnType)
                  ),
                );
              }),
            );
            break;
        }
      })())
    );
  }
}




