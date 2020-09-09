import 'package:Bishal/model/mcq_state.dart';
import 'package:Bishal/redux/actions.dart';
import 'package:Bishal/model/app_state.dart';
import 'package:pdf/widgets.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is FontSize) {
    newState.sliderFontSize = action.payload;
  } else if (action is Bold) {
    newState.bold = action.payload;
  } else if (action is Italic) {
    newState.italic = action.payload;
  }
  return newState;
}

MCQState reducerMCQ(MCQState prevState, dynamic action) {
  MCQState newState = MCQState.fromMCQState(prevState);

  if (action is TopicSelection) {
    // newState.numberRange = action.payload;
  } else if (action is SubmitAnswer) {
    newState.calculateResult();
  }


}