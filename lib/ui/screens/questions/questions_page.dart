import 'dart:ui';

import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/redux/question/question_actions.dart';
import 'package:Bishal/ui/screens/questions/question_text_view.dart';
import 'package:Bishal/viewmodels/question_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Bishal/models/topics.dart';

class QuestionsPage extends StatelessWidget {
  static final String routeName = "/questions";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QuestionPageViewModel>(
      onInit: (store) => store.dispatch(InitQuestions()),
      distinct: true,
      converter: (store) => QuestionPageViewModel.fromStore(store),
      builder: (context, vm) => QP3(vm: vm),
    );
  }
}

class QP3 extends StatelessWidget {
  final QuestionPageViewModel vm;

  const QP3({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: vm.questions.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: "${index+1}. ",style: Theme.of(context).textTheme.headline5),
                          TextSpan(text: vm.questions[index].questionText)
                ], style: Theme.of(context).textTheme.headline6,)),
                InputTextView2(viewModel: vm,currentIndex: index,)
              ],
            );
          },
        ),
      ),
    );
  }
}

class QP2 extends StatelessWidget {
  final QuestionPageViewModel vm;

  const QP2({Key key, this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: false,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () => Future.value(true),
            child: Center(
                child: Column(
              children: [
                QuestionTextView(
                  viewModel: vm,
                ),
                InputTextView(
                  viewModel: vm,
                ),
                PreNextButtonView(
                  viewModel: vm,
                )
              ],
            )),
          ),
        ));
  }
}

class QuestionPageContent extends StatelessWidget {
  final QuestionPageViewModel vm;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  QuestionPageContent({this.vm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.topicEnum.toDisplayedString.toUpperCase()),
      ),
      body: WillPopScope(
        onWillPop: () => Future.value(true),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Time Left: "),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text( "",
                            // "${vm.currentQuestionIndex + 1}. ${vm.questions[vm.currentQuestionIndex].questionText}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 200,
                    child: TextField(
                        key: _key,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.headline6,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 5.0),
                          ),
                          hintText: 'Answer',
                        ),
                        // onChanged: vm.modifyAnswer
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_back),
                        onPressed: vm.previousQuestion,
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_forward),
                        onPressed: vm.nextQuestion,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.all(4),
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color: Colors.black, style: BorderStyle.solid)),
                        child: Center(
                            child: Text(
                          "Submit Test",
                          style: TextStyle(fontSize: 20.0),
                        ))),
                    onTap: () => {},
                  ),
                  Spacer()
                ],
              ),
            ),
//        onWillPop: () => Future.value(false),
          ),
        ),
      ),
    );
  }
}
