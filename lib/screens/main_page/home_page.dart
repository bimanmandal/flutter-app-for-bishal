import 'package:Bishal/common/app_bar.dart';
import 'package:Bishal/screens/formula/formula_home.dart';
import 'package:Bishal/screens/info_page/info_page.dart';
import 'package:Bishal/screens/learn/learn_home.dart';
import 'package:Bishal/screens/my_tests/my_tests_page.dart';
import 'package:Bishal/screens/test_list/test_list.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const int learn = 0;
  static const int formulas = 1;
  static const int writeTests = 2;
  static const int myTests = 3;
  static const int profile = 4;

  final _tabs = {
    learn: 'learn',
    formulas: 'formulas',
    writeTests: 'writeTests',
    myTests: 'myTests',
    profile: 'profile',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BishalAppBar(),
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: _currentIndex,
            children: <Widget>[
              LearnHomePage(),
              FormulaHomePage(),
              TestList(),
              MyTestsPage(),
              InfoPage()
            ],
          )
        ],
      ),
      bottomNavigationBar: createBottomNavigation(),
    );
  }

  BottomNavigationBar createBottomNavigation() {
    final itemHeight = 22.0;
    final textSize = 12.0;

    return BottomNavigationBar(
      showSelectedLabels: false,
      // showUnselectedLabels: false,
      currentIndex: _currentIndex,
      unselectedItemColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).bottomAppBarTheme.color
          : Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: textSize,
      unselectedFontSize: textSize,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Container(
            height: itemHeight,
            child: Icon(LineIcons.book),
          ),
          label: 'Learn'
        ),
        BottomNavigationBarItem(
            icon: Container(
              height: itemHeight,
              child: Icon(LineIcons.dna),
            ),
            label: 'Gens'
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: itemHeight,
            child: Icon(LineIcons.pen),
            // child: Icon(LineIcons.pencil_square_o),
          ),
          label: 'Write Test',
        ),
        BottomNavigationBarItem(
            icon: Container(
              height: itemHeight,
              child: Icon(LineIcons.database),
            ),
            label: 'My Tests'
        ),
        BottomNavigationBarItem(
            icon: Container(
              height: itemHeight,
              child: Icon(LineIcons.infoCircle),
            ),
            label: 'Info'
        )
      ],
    );
  }

}
