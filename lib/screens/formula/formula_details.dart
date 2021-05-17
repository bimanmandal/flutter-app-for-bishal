import 'dart:math';

import 'package:Bishal/common/app_bar.dart';
import 'package:Bishal/models/formula_type.dart';
import 'package:Bishal/screens/formula/widgets/webview_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'formulaData.dart';

class FormulaDetails extends StatelessWidget {
  final FormulaType formulaType;
  final String DOMAIN = "https://bishal-karmakar.web.app/";

  const FormulaDetails({Key key, this.formulaType}) : super(key: key);

  //WebViewFormulaWidget(url: "https://bishal-karmakar.web.app/sets.html",)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BishalAppBar(),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: formulaData[formulaType].map((chapter) =>
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Theme
                    .of(context)
                    .accentColor)),
            child: ListTile(
              leading: Icon(LineIcons.dna),
              title: Text(
                chapter.keys.first,
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                final String url = "${DOMAIN}${chapter.values.first}";
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewFormulaWidget(url: url,)));
              }
            ))).toList()
          ),
    );
  }
}




