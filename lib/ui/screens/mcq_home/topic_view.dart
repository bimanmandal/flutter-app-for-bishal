import 'package:Bishal/models/topics.dart';
import 'package:Bishal/ui/screens/questions/questions_page.dart';
import 'package:flutter/material.dart';

class TopicView extends StatelessWidget {
  final TopicEnum topic;
  final void Function(TopicEnum) onSelectedTopic;

  const TopicView({Key key, this.topic, this.onSelectedTopic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border:
                      Border.all(color: Colors.black, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Center(
                  child: Text(
                "${topic.toDisplayedString.toUpperCase()}",
                style: Theme.of(context).textTheme.bodyText1,
              ))),
          onTap: () => {onSelectedTopic(topic),
          Navigator.of(context).pushNamed(QuestionsPage.routeName)},
        );
  }
}
