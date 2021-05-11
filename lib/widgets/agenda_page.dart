import 'package:flutter/material.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  PageController pageController;
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      if(pageController.page.round() != currentIndex.value) {
        currentIndex.value = pageController.page.round();
      }
    });

    currentIndex.addListener(() {setState(() {

    });});

  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Agenda Page"),),);
  }
}
