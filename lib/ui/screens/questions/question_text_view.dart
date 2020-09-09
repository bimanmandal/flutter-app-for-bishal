import 'dart:ui';

import 'package:Bishal/viewmodels/question_page_view_model.dart';
import 'package:flutter/material.dart';

class QuestionTextView extends StatelessWidget {
  final QuestionPageViewModel viewModel;

  const QuestionTextView({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text( "",
        // "${viewModel.currentQuestionIndex + 1}. ${viewModel.questions[viewModel.currentQuestionIndex].questionText}",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class InputTextView2 extends StatefulWidget {
  final QuestionPageViewModel viewModel;
  final int currentIndex;

  InputTextView2({Key key, this.viewModel, this.currentIndex}) : super(key: key);

  @override
  _InputTextView2State createState() => _InputTextView2State();
}

class _InputTextView2State extends State<InputTextView2> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.viewModel.questions[widget.currentIndex].providedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Answer',
          ),
          // textAlign: TextAlign.center,
          onChanged: (value) => widget.viewModel.modifyAnswer(value,widget.currentIndex),
        ),
      ],
    );
  }
}

class InputTextView extends StatefulWidget {
  final QuestionPageViewModel viewModel;

  const InputTextView({Key key, this.viewModel}) : super(key: key);

  @override
  _InputTextViewState createState() => _InputTextViewState();
}

class _InputTextViewState extends State<InputTextView> {
  final TextEditingController controller = TextEditingController();

  // @override
  // void initState() {
  //   controller.text = widget.viewModel
  //       .questions[widget.viewModel.currentQuestionIndex].providedAnswer;
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Answer',
          ),
          // textAlign: TextAlign.center,
          // onChanged: widget.viewModel.modifyAnswer,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Icon(Icons.arrow_back),
              onPressed: () {
                widget.viewModel.previousQuestion();
              },
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Icon(Icons.arrow_forward),
              onPressed: widget.viewModel.nextQuestion,
            ),
          ],
        )
      ],
    );
  }
}

class PreNextButtonView extends StatelessWidget {
  final QuestionPageViewModel viewModel;

  const PreNextButtonView({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
