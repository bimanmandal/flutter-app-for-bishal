import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/topic.dart';
import 'package:Bishal/models/topics.dart';
import 'package:Bishal/ui/widgets/two_number.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class MCQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bishal".toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topicWidget(
                Topic("Multiplication Tables", TopicEnum.MULTIPLICATION_TABLES),
                context),
            topicWidget(Topic("Squares", TopicEnum.SQUARES), context),
            topicWidget(Topic("Cubes", TopicEnum.CUBES), context),

          ],
        ),
      ),
    );
  }

  Widget topicWidget(Topic topic, BuildContext context) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.all(12.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Colors.black, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Center(
              child: Text(
            "${topic.name}",
            style: Theme.of(context).textTheme.headline5,
          ))),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>   TwoNumber(
                    topic: topic,
                  ),
              settings: RouteSettings())),
    );
  }
}



