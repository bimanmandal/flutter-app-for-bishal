import 'package:Bishal/components/drawer_menu.dart';
import 'package:Bishal/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AboutPage extends StatelessWidget {
  static String routeName = "/about";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      drawer: DrawerMenu(),
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) {
         return Container(
           margin: EdgeInsets.all(10.0),
           child: RichText(
             text: TextSpan(
                 text: lorem(paragraphs: 3, words: 100),
                 style: TextStyle(
                     fontSize: vm.viewFontSize,
                     fontStyle: vm.italic? FontStyle.italic : FontStyle.normal ,
                     fontWeight: vm.bold? FontWeight.bold : FontWeight.normal,
                     color: Colors.lightBlue)
             ),
           ),
         );
        },

      ),
    );
  }
}
