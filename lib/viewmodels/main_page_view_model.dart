
import 'package:Bishal/models/topics.dart';
import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/redux/common/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class MainPageViewModel {
  final RangeValues numberRange;
  final TopicEnum topic;
  final Function(RangeValues) changeRange;
  final Function(TopicEnum) selectTopic;

  MainPageViewModel({
    @required this.numberRange,
    @required this.topic,
    @required this.changeRange,
    @required this.selectTopic,
  });

  static MainPageViewModel fromStore(Store<AppState> store) {
    return MainPageViewModel(
      numberRange: store.state.numberRange,
      topic: store.state.currentTopic,
      changeRange: (newRange) => {
        store.dispatch(ChangeRangeAction(newRange))
      },
      selectTopic: (newTopic) => {
        store.dispatch(SelectTopicAction(newTopic))
      }
    );
  }
}