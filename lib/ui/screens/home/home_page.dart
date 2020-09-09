import 'package:Bishal/components/drawer_menu.dart';
import 'package:Bishal/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      drawer: DrawerMenu(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return RichText(
                text: TextSpan(
                    text: lorem(paragraphs: 3, words: 50),
                    style: TextStyle(
                        fontSize: state.viewFontSize,
                        fontStyle:
                            state.italic ? FontStyle.italic : FontStyle.normal,
                        fontWeight:
                            state.bold ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black)),
              );
            }),
      ),
    );
  }
}
