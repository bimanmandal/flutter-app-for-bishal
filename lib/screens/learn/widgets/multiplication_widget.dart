import 'package:Bishal/screens/learn/widgets/multiplication_table.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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

class Item {
  Item({
    this.id,
    this.expandedValue,
    this.headerValue,
  });

  int id;
  String headerValue;
  Widget expandedValue;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (index) =>
     Item(
      id:index,
      headerValue: "${index + 1}",
      expandedValue: multiplicationTable(index+1)
    )
  );
}



Widget multiplicationTable(table){
  return ListView.builder(
    itemCount: 10,
    // scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Container(
          height: 50,
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
    },);
}

class MultiplicationWidget extends StatelessWidget {
  List<Item> _data = generateItems(50);
  GlobalKey expansionTileKey = GlobalKey();
  MultiplicationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {

    return ExpansionPanelList.radio(
      // initialOpenPanelValue: 1,
      children: _data.map<ExpansionPanelRadio>((Item item) {
        return
          ExpansionPanelRadio(
              value: item.id,
              headerBuilder: (BuildContext context, bool isExpanded) => ListTile(title: Text(item.headerValue),),
              body: item.expandedValue);
      }).toList(),
    );
  }
}
void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
  final keyContext = expansionTileKey.currentContext;
  if (keyContext != null) {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      Scrollable.ensureVisible(keyContext,
          duration: Duration(milliseconds: 200));
    });
  }
}

