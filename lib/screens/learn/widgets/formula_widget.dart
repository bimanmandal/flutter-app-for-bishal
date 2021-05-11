import 'dart:convert';

import 'package:Bishal/models/formula.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:rxdart/rxdart.dart';

class FormulaWidget extends StatefulWidget {
  final String formulaPath;

  const FormulaWidget({Key key, this.formulaPath}) : super(key: key);

  @override
  _FormulaWidgetState createState() => _FormulaWidgetState();
}

class _FormulaWidgetState extends State<FormulaWidget> {
  final TeXViewRenderingEngine renderingEngine = TeXViewRenderingEngine.katex();
  final BehaviorSubject<List<Formula>> _formulas = BehaviorSubject<List<Formula>>();


  @override
  void initState() {
    getFileData(widget.formulaPath).then((data) {
      List<dynamic> lists = json.decode(data) as List;
      List<Formula> formulas = lists.map((element) => (Formula.fromJson(element))).toList();
      _formulas.add(formulas);
    });
  }

   Stream<List<Formula>> getData()  {
    return Stream.fromFuture(getFileData("assets/formulas/algebra/algebra.json"))
    .map((data) => (json.decode(data)).map((e) => Formula.fromJson(e)));
  }

   getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Formula>>(
      stream: _formulas,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return CircularProgressIndicator();;
        }
        else {
          print("I have data");
          // return Text(snapshot.data[0].body);
          return ListView(
            physics: ScrollPhysics(),
            children: [
              TeXView(
                renderingEngine: renderingEngine,
                child: TeXViewColumn(
                  children: [
                    ...texWidgets(context, snapshot.data)
                  ]
                ),
                style: TeXViewStyle(
                  // elevation: 10,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor
                ),
                loadingWidgetBuilder: (context) => Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      Text("Rendering...")
                    ],
                  ),
                ),
              )
            ],
          );
          print(snapshot.data);
          return Text("hello");
        }
      },
    );
  }
}

List<TeXViewWidget> texWidgets(BuildContext context, List<Formula> formulas) {
  return formulas.map((formula) {
    return TeXViewColumn(
        style: TeXViewStyle(
            margin: TeXViewMargin.all(4),
            padding: TeXViewPadding.all(4),
            borderRadius: TeXViewBorderRadius.all(4),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                // borderStyle: TeXViewBorderStyle.Groove,
                borderColor: Theme.of(context).accentColor))),
        children: [
          if(formula.title.isNotEmpty)
          TeXViewDocument(formula.title,
              style: TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(4),
                  textAlign: TeXViewTextAlign.Center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Theme.of(context).accentColor)),
          TeXViewDocument(converListToTextViewDocument(formula.body),
              style: TeXViewStyle(
                  margin: TeXViewMargin.only(top: 10),
                  contentColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white

              ))
        ]
    );
  }).toList();
}

String converListToTextViewDocument(List<String> body) {
  return body.map((e) => "\$\$"+e+"\$\$").join(" ");
}