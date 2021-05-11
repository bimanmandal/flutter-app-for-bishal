import 'package:Bishal/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MultiplicationTablePage extends StatelessWidget {
  final int table;

  const MultiplicationTablePage({Key key, this.table}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BishalAppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Theme
                      .of(context)
                      .accentColor)),
              child: ListTile(
                leading: Icon(LineIcons.table),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("$table"),
                    SizedBox(width: 12,),
                    Text("X"),
                    SizedBox(width: 12,),
                    Text("${index + 1}"),
                    SizedBox(width: 12,),
                    Text("="),
                    SizedBox(width: 12,),
                    Text("${table * (index + 1)}"),
                  ],
                ),
              )
          );
        },),
    );
  }
}