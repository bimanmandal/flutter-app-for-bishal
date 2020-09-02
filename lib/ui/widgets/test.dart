import 'dart:async';
import 'dart:math';

import 'package:Bishal/models/question.dart';
import 'package:Bishal/models/topics.dart';
import 'package:Bishal/ui/widgets/result.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final RangeValues rangeValues;
  final TopicEnum topicEnum;

  const Test({Key key, this.rangeValues, this.topicEnum}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int _currentQuestionIndex = 0;
  List<NumberQuestion> questions = List();
  TextEditingController _textEditingController = TextEditingController();
  int timer = 0;
  bool cancelTimer = false;

  _checkAnswer(String value, NumberQuestion numberQuestion) {
    setState(() {
      if (value != null) {
        numberQuestion.setProvidedAnswer(value);
        numberQuestion.setIsCorrect(
            double.parse(numberQuestion.correctAnswer) == double.parse(value));
      }
    });
  }

  _genUniqueRandomNumber(int start, int end, int size) {
    var randomNumberGenerator = new Random();
    List<int> uniqueNums = List();
    if (size > end - start + 1)
      return List<int>();
    else if (size == end - start + 1) {
      uniqueNums = List.generate(end - start + 1, (index) => start + index);
    } else {
      while (uniqueNums.length < size) {
        int randomNumber = start + randomNumberGenerator.nextInt(end - start);
        if (!uniqueNums.contains(randomNumber)) uniqueNums.add(randomNumber);
      }
    }
    uniqueNums.shuffle();
    return uniqueNums;
  }

  _genUniqueMultiplicationCombinations(int start, int end) {
    var randomNumberGenerator = new Random();
    Map<String, int> multiplication = Map();
    if (start == end) {
      for (int i = 1; i <= 10; i++) {
        multiplication["$start X $i"] = start * i;
      }
    }
    while (multiplication.length != 10) {
      int randomNumber = 1 + randomNumberGenerator.nextInt(10);
      int randomTable = start + randomNumberGenerator.nextInt(end - start);
      String key = "$randomTable X $randomNumber";
      int value = randomTable * randomNumber;
      multiplication[key] = value;
    }
    return multiplication;
  }

  @override
  void initState() {
    int start = widget.rangeValues.start.round();
    int end = widget.rangeValues.end.round();
    int numberOfQuestions = (end - start + 1 >= 10) ? 10 : end - start + 1;

    switch (widget.topicEnum) {
      case TopicEnum.MULTIPLICATION_TABLES:
        {
          Map<String, int> multiplication =
          _genUniqueMultiplicationCombinations(start, end);
          multiplication.keys.forEach((key) {
            String question = "Find the multiplication of $key";
            String answer = "${multiplication[key]}";
            questions.add(NumberQuestion.set(question, answer));
          });
        }
        break;
      case TopicEnum.SQUARES:
        {
          List<int> nums =
          _genUniqueRandomNumber(start, end, numberOfQuestions);
          nums.forEach((number) {
            String question = "Find the square of $number";
            String answer = "${number * number}";
            questions.add(NumberQuestion.set(question, answer));
          });
        }
        break;
      case TopicEnum.CUBES:
        {
          List<int> nums =
          _genUniqueRandomNumber(start, end, numberOfQuestions);
          nums.forEach((number) {
            String question = "Find the cube of $number";
            String answer = "${number * number * number}";
            questions.add(NumberQuestion.set(question, answer));
          });
        }
        break;
      default:
        debugPrint("default: ${widget.topicEnum}");
        break;
    }

    timer = questions.length * 5;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test",
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: WillPopScope(
        onWillPop: () => Future.value(false),
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
                        Text(
                          "$timer",
                          style: TextStyle(
                            fontSize: 20,
                            color: (timer <= 5) ? Colors.redAccent : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "${_currentQuestionIndex + 1}. ${questions[_currentQuestionIndex].questionText}",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.headline6,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.greenAccent, width: 5.0),
                        ),
                        hintText: 'Answer',
                      ),
                      onChanged: (value) =>
                          _checkAnswer(value, questions[_currentQuestionIndex]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_back),
                        onPressed: _changeQuestionBackWard,
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_forward),
                        onPressed: _changeQuestionForward,
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
                              style: TextStyle(fontSize: 25.0),
                            ))),
                    onTap: () => _navigateToResult(),
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

  _changeQuestionForward() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questions.length;
      _textEditingController.clear();
      _textEditingController = TextEditingController(
          text: questions[_currentQuestionIndex].providedAnswer);
    });
  }

  _changeQuestionBackWard() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex - 1) % questions.length;
      _textEditingController.clear();
      _textEditingController = TextEditingController(
          text: questions[_currentQuestionIndex].providedAnswer);
    });
  }

  _navigateToResult() {
    setState(() {
      cancelTimer = true;
    });
    return Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Result(
        questions: this.questions,
      ),
    ));
  }

  _startTimer() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!cancelTimer)
        setState(() {
          if (timer < 1) {
            t.cancel();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Result(
                questions: this.questions,
              ),
            ));
          } else if (cancelTimer == true && t.isActive) {
            t.cancel();
          } else {
            timer = timer - 1;
          }
        });
    });
  }
}
