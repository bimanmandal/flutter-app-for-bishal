import 'dart:async';

import 'package:Bishal/models/question.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Result extends StatelessWidget {
  final List<NumberQuestion> questions;

  const Result({Key key, this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home), onPressed: () => Navigator.pop(context)),
        ],
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Your Score : ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _sharePdf(questions),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return getResult(questions, index, context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _sharePdf(List<NumberQuestion> questions) async {
    int numberOfQuestions = 0;
    int result = 0;

    questions.forEach((question) {
      if (question.isCorrect) result += 1;
      numberOfQuestions += 1;
    });

    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(10.0),
        build: (pw.Context context) => pw.Container(
          child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: <pw.Widget>[
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Text("Test Result",
                          style: pw.TextStyle(
                            fontSize: 30.0,
                            fontWeight: pw.FontWeight.bold,
                          ))
                    ]),
                pw.Divider(),
                pw.Divider(),
                pw.SizedBox(height: 10.0),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text("Time : ${new DateTime.now()}"),
                      pw.Text("Score: $result / $numberOfQuestions")
                    ]),
                pw.SizedBox(height: 20.0),
                pw.Divider(),
                pw.ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return pw.Container(
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: <pw.Widget>[
                          pw.Row(children: <pw.Widget>[
                            pw.Text(
                                "${index + 1}. ${questions[index].questionText}"),
                          ]),
                          pw.Padding(
                              padding: pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: <pw.Widget>[
                                    pw.Text(
                                        "Answer: ${questions[index].providedAnswer}"),
                                    pw.Text(
                                        "${(questions[index].isCorrect) ? 'CORRECT' : 'INCORRECT'}",
                                        style: pw.TextStyle(
                                            color: (questions[index].isCorrect)
                                                ? PdfColor.fromHex("008000")
                                                : PdfColor.fromHex("FF0000"))),
                                  ])),
                          pw.SizedBox(height: 10.0)
                        ]));
                  },
                ),
              ]),
        ),
      ),
    );

    await Share.file("Result", "result.pdf", doc.save(), '*/*');
  }

  pw.Widget HorizontalLine(double size) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 10.0),
      child: pw.Container(
        height: size,
        width: 400,
        decoration: pw.BoxDecoration(color: PdfColor.fromHex("FFFFFF")),
      ),
    );
  }

  Widget getResult(
      List<NumberQuestion> questions, int index, BuildContext context) {
    return Card(
      child: Container(
        width: 150,
//        height: 300,
        decoration: BoxDecoration(
            border: Border.all(
                color: questions[index].isCorrect
                    ? Colors.greenAccent
                    : Colors.redAccent,
                style: BorderStyle.solid,
                width: 2.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                      child: Text(
                    "${index + 1}. ${questions[index].questionText}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 17),
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Answer: "),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${questions[index].providedAnswer} ")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
