import 'dart:math';

import 'package:Bishal/common/app_bar.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class ResultPage extends StatelessWidget {

  calculateScore(List<Question> questions) {
    int totalQuestions = 0;
    int score = 0;
    questions.forEach((element) {
      if (element.answer == element.providedAnswer) score++;
      totalQuestions++;
    });
    return "$score / $totalQuestions";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BishalAppBar(),
        body: StreamBuilder<List<Question>>(
            stream: RepositoryProvider.of<ExamRepository>(context).questions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Score: ${calculateScore(snapshot.data)}"),
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color:
                                              Theme.of(context).accentColor)),
                                  child: ListTile(
                                      title: Text(
                                          snapshot.data[index].questionText),
                                      subtitle: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Your Answer: "),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(snapshot.data[index]
                                                      .providedAnswer ??"")
                                            ],
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          if (snapshot
                                                  .data[index].providedAnswer !=
                                              snapshot.data[index].answer)
                                            Row(
                                              children: [
                                                Text("Correct Answer: "),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                    snapshot.data[index].answer)
                                              ],
                                            )
                                        ],
                                      ),
                                      trailing:
                                          snapshot.data[index].providedAnswer ==
                                                  snapshot.data[index].answer
                                              ? Icon(
                                                  LineIcons.check,
                                                  color: Colors.green,
                                                  size: 32,
                                                )
                                              : Icon(
                                                  LineIcons.times,
                                                  color: Colors.red,
                                                  size: 32,
                                                )),
                                );
                              }))
                    ]);
              } else {
                return Container();
              }
            }));
  }


}
