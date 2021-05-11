import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/models/range_values.dart';
import 'package:Bishal/models/test_type.dart';
import 'package:Bishal/question/bloc/blocks.dart';
import 'package:Bishal/question/bloc/question_bloc.dart';
import 'package:Bishal/screens/write_test/write_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestList extends StatelessWidget {
  final topicMap = {
    "Multiplication": TestType.MULTIPICATION,
    "Square": TestType.SQUARES,
    "Cube": TestType.CUBE
  };

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        // scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        children: topicMap.keys.map((String topic) {
          return GridTile(
              child: Card(
            shadowColor: Theme.of(context).accentColor,
            margin: EdgeInsets.all(4),
            child: InkWell(
              onTap: () => _showMyDialog(context, topicMap[topic]),
              child: Center(
                  child: Text(
                topic,
                style: TextStyle(fontSize: 20),
              )),
            ),
          ));
        }).toList());
  }

  Future<void> _showMyDialog(BuildContext context, TestType testType) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("test-type", testType.toString());
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Number Range'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RangeSliderView(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.all(10),
                      child: Text('Give Test'),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final range = RangeValue(prefs.getDouble("range-start"),
                            prefs.getDouble("range-end"));
                        BlocProvider.of<TestBloc>(context).add(TestStarted());
                        BlocProvider.of<QuestionBloc>(context)
                            .add(QuestionSelectedEvent());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WriteTestPage(),
                            ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class RangeSliderView extends StatefulWidget {
  @override
  _RangeSliderViewState createState() => _RangeSliderViewState();
}

class _RangeSliderViewState extends State<RangeSliderView> {
  var selectedRange = RangeValues(10, 15);

  @override
  void initState() {
    _loadFromPrefs();
    super.initState();
  }

  _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("range-start")) {
      prefs.setDouble("range-start", 10);
      prefs.setDouble("range-end", 15);
    }
    setState(() {
      selectedRange = RangeValues(
          prefs.getDouble("range-start"), prefs.getDouble("range-end"));
    });
  }

  _rangeChanged(RangeValues rangeValues) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setDouble("range-start", rangeValues.start);
    sharedPrefs.setDouble("range-end", rangeValues.end);
    setState(() {
      selectedRange = rangeValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("${selectedRange.start.round()}"),
        RangeSlider(
          values: selectedRange,
          onChanged: _rangeChanged,
          min: 1,
          max: 50,
          divisions: 50,
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).accentColor.withOpacity(0.4),
        ),
        Text("${selectedRange.end.round()}"),
      ],
    );
  }
}
