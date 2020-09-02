import 'package:Bishal/models/topic.dart';
import 'package:Bishal/ui/widgets/test.dart';
import 'package:flutter/material.dart';

class TwoNumber extends StatefulWidget {
  final Topic topic;

  const TwoNumber({Key key, this.topic}) : super(key: key);

  @override
  _TwoNumberState createState() => _TwoNumberState();
}

class _TwoNumberState extends State<TwoNumber> {
  var _selectedRange = RangeValues(15, 25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.topic.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
//        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Select a number range: ",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${_selectedRange.start.round()}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: SliderTheme(
                        data: Theme.of(context).sliderTheme,
                        child: RangeSlider(
                          values: _selectedRange,
                          onChanged: (RangeValues newRange) => setState(() {
                            _selectedRange = newRange;
                          }),
                          min: 1,
                          max: 50,
                          divisions: 50,
                          labels: RangeLabels(
                            "${_selectedRange.start.round()}",
                            "${_selectedRange.end.round()}",
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${_selectedRange.end.round()}",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(
                          style: BorderStyle.solid,
                        ),
                        color: Theme.of(context).primaryColor),
                    child: Center(
                        child: Text(
                          "Give Test!!",
                          style: Theme.of(context).textTheme.headline5,
                        )),
                  ),
                ),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test(
                        rangeValues: _selectedRange,
                        topicEnum: widget.topic.topicEnum,
                      ),
                    )),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
