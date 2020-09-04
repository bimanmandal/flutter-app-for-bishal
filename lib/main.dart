import 'package:Bishal/model/app_state.dart';
import 'package:Bishal/redux/reducers.dart';
import 'package:Bishal/routes.dart';
import 'package:Bishal/screens/home/home_page.dart';
import 'package:Bishal/screens/sign_in_screen.dart';
import 'package:Bishal/theme.dart';
import 'package:Bishal/ui/App.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() {
  final _initalState = AppState(sliderFontSize: 0.5);
  final Store<AppState> _store = Store<AppState>(reducer, initialState: _initalState);
  runApp(MyAPP( store: _store));
}

class MyAPP extends StatelessWidget {
  final Store<AppState> store;
  const MyAPP({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bishal App',
        theme: theme(),
        initialRoute: HomePage.routeName,
        routes: routes,
      ),
    );
  }
}

