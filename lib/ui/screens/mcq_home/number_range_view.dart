import 'package:flutter/material.dart';

class NumberRangeView extends StatelessWidget {

  final RangeValues selectedRange;
  final void Function(RangeValues) onRangeChanged;

  const NumberRangeView({Key key, this.onRangeChanged, this.selectedRange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${selectedRange.start.round()}",
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: SliderTheme(
              data: Theme.of(context).sliderTheme,
              child: RangeSlider(
                values: selectedRange,
                onChanged: (RangeValues newRange) => onRangeChanged(newRange),
                min: 1,
                max: 50,
                divisions: 50,
                labels: RangeLabels(
                  "${selectedRange.start.round()}",
                  "${selectedRange.end.round()}",
                ),
              ),
            ),
          ),
          Text(
            "${selectedRange.end.round()}",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
