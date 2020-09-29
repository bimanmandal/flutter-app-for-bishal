import 'package:Bishal/screens/learn/widgets/multiplication_table.dart';
import 'package:flutter/material.dart';

Widget multiplicationWidget(BuildContext context , int index) {
  return InkWell(
    onTap: () {
      return Navigator.push(context, MaterialPageRoute(builder: (context) => MultiplicationTablePage(table: index+1,),));
    },
    child: Center(
      child: Text("${index + 1}", style: TextStyle(fontSize: 24),),
    ),
  );
}