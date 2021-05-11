import 'package:flutter/material.dart';

class DaySelectorContainer extends StatelessWidget {
  final PageController pageController;
  final int index;

  const DaySelectorContainer({Key key, this.pageController, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).brightness == Brightness.light
        ? Colors.blue[100]
        : Colors.blue[900];

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: bgColor, style: BorderStyle.solid, width: 2),
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              DaySelector(
                  bgColor: bgColor,
                  pageController: pageController,
                  index: index)
            ],
          ),
        ),
      ),
    );
  }
}

class DaySelector extends StatelessWidget {
  final Color bgColor;
  final PageController pageController;
  final int index;

  const DaySelector({Key key, this.bgColor, this.pageController, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
