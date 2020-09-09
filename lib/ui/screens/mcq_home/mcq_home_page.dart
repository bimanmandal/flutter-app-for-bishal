import 'package:Bishal/models/topics.dart';
import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/ui/screens/mcq_home/number_range_view.dart';
import 'package:Bishal/ui/screens/mcq_home/topic_view.dart';
import 'package:Bishal/viewmodels/main_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MCQHomePage extends StatelessWidget {
  static final String routeName = "/mcqHome";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainPageViewModel>(
      distinct: true,
      converter: (store) => MainPageViewModel.fromStore(store),
      builder: (context, vm) => MCQHomePageContent(vm),
    );
  }
}

class MCQHomePageContent extends StatelessWidget {
  final MainPageViewModel mainPageViewModel;

  const MCQHomePageContent(this.mainPageViewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bishal".toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NumberRangeView(
              onRangeChanged: mainPageViewModel.changeRange,
              selectedRange: mainPageViewModel.numberRange,
            ),
            SizedBox(height: 50,),
            ...[TopicEnum.MULTIPLICATION_TABLES, TopicEnum.SQUARES, TopicEnum.CUBES].map((e) => TopicView(topic: e, onSelectedTopic:mainPageViewModel.selectTopic ,))
          ],
        ),
      ),
    );
  }
}