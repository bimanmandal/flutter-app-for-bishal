import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/models/question.dart';
import 'package:Bishal/question/bloc/blocks.dart';
import 'package:Bishal/screens/write_test/result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class WriteTestPage extends StatefulWidget {
  @override
  _WriteTestPageState createState() => _WriteTestPageState();
}

class _WriteTestPageState extends State<WriteTestPage> {
  @override
  Widget build(BuildContext context) {
    final examRepository = RepositoryProvider.of<ExamRepository>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Theme.of(context).brightness == Brightness.dark
                ? Text(
                    "Tests",
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    "Tests",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          brightness: Theme.of(context).brightness,
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).accentColor),

        ),
        body: BodyWidget());
  }
}

class Hello extends StatelessWidget {
  final List<Question> questions;

  Hello({Key key, this.questions}) : super(key: key);
  final PageController _controller = PageController(initialPage: 0,);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
              child: Stack(
            children: [
              Wrap(
                children: [
                  Text("${index + 1}. ${questions[index].questionText}",
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
              Align(
                alignment: Alignment(0, -0.25),
                child: InputBox(
                  index: index,
                  answer: questions[index].providedAnswer,
                ),
              ),
              if (index != 0)
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: Icon(
                      LineIcons.chevron_circle_left,
                      size: 64,
                    ),
                    onTap: () {
                      _controller.animateToPage(--index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
              if (index != questions.length - 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Icon(
                      LineIcons.chevron_circle_right,
                      size: 64,
                    ),
                    onTap: () {
                      _controller.animateToPage(++index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
            ],
          ));
        },
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  final int index;
  final String answer;


  InputBox({Key key, this.index, this.answer}) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  TextEditingController _textEditingController;


  @override
  void initState() {
      _textEditingController = TextEditingController();
      _textEditingController.text = widget.answer;
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: TextField(
        controller: _textEditingController,
        keyboardType: TextInputType.number,
        autofocus: true,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          // labelText: "Answer",
        ),
        onChanged: (value) => BlocProvider.of<QuestionBloc>(context)
            .add(ChangeAnswer(value, widget.index)),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestBloc, TestState>(
      listener: (context, state) {
        if (state is TestComplete) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(),
              ));
        }
      },
      builder: (context, state) {
        if (state is TestInProgress) {
          final String minutesStr =
              ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
          final String secondsStr =
              (state.duration % 60).floor().toString().padLeft(2, '0');
          return StreamBuilder<List<Question>>(
            stream: RepositoryProvider.of<ExamRepository>(context).questions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(
                      '$minutesStr:$secondsStr',
                      style: TextStyle(
                          color:
                              state.duration <= 5 ? Colors.red : Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Hello(
                      questions: snapshot.data,
                    ),
                    FlatButton(
                      child: Text("Submit Exam", style: TextStyle(fontSize: 32),),
                      onPressed: () {
                        BlocProvider.of<TestBloc>(context)..add(TestFinished());
                        return Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(),
                            ));
                      },
                    )
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
