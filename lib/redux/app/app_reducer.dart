import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/redux/common/common_reducers.dart';
import 'package:Bishal/redux/question/question_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
      questionState: questionReducer(state, action),
      numberRange: numberRangeReducer(state.numberRange, action),
      currentTopic: topicChangeReducer(state.currentTopic, action),
      result: state.result);
}