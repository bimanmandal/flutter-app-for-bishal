import 'package:Bishal/exam/models/exam_details.dart';
import 'package:Bishal/exam/models/exam_details.dart';
import 'package:Bishal/exam/models/exam_summary.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class MyTestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExamSummary>>(
      stream: RepositoryProvider.of<ExamRepository>(context).getAllSummaries(),
      builder: (context, AsyncSnapshot<List<ExamSummary>> snapshot) {
        if(!snapshot.hasData)
          return CircularProgressIndicator();
        if (snapshot.hasData && snapshot.data.isEmpty)
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/no_data.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Here you will get all your attempted Tests'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Write some test!!'),
                ),
              ],
            ),
          );
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Theme
                      .of(context)
                      .accentColor)),
              child: ListTile(
                dense: false,
                leading: Icon(LineIcons.caret_right,),
                title: Text(snapshot.data[index].examName),
                subtitle: Text(snapshot.data[index].score),
                trailing: Text("${DateFormat('dd MMM').format(snapshot.data[index].dateTime)}"),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      ExamDetailsPage(
                        examId: "${snapshot.data[index].examId}",
                        examName: "${snapshot.data[index].examName}",
                      ),)),
              ),
            );
          },
        );
      },
    );
  }
}

class ExamDetailsPage extends StatelessWidget {
  final String examId;
  final String examName;

  const ExamDetailsPage({Key key, @required this.examId, this.examName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Theme.of(context).brightness == Brightness.dark
              ? Text(examName, style: TextStyle(color: Colors.white),)
              :Text(examName, style: TextStyle(color: Colors.black, ),),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        brightness: Theme.of(context).brightness,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Theme.of(context).accentColor),
      ),
      body: StreamBuilder<List<ExamDetails>>(
        stream: RepositoryProvider.of<ExamRepository>(context).getExamDetails(examId),
        builder: (context, AsyncSnapshot<List<ExamDetails>> snapshot) {
          if(!snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color:  Theme.of(context).accentColor)),
                child: ListTile(
                  title: Text(snapshot.data[index].question),
                  subtitle: Row(
                    children: [
                      Text("Your Answer: "),
                      SizedBox(width: 10,),
                      Text(snapshot.data[index].answer)
                    ],
                  ),
                  trailing: snapshot.data[index].isCorrect
                  ? Icon(LineIcons.check, color: Colors.green, size: 32,)
                  : Icon(LineIcons.times, color: Colors.red, size: 32,)
                ),
              );
            },
          );
        },
      ),
    );
  }
}

