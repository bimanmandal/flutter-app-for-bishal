import 'package:Bishal/redux/app/app_reducer.dart';
import 'package:Bishal/redux/app/app_state.dart';
import 'package:Bishal/routes.dart';
import 'package:Bishal/ui/screens/mcq_home/mcq_home_page.dart';
import 'package:Bishal/theme.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() {
  final _initalState = AppState.initial();
  final Store<AppState> _store = Store<AppState>(
      appReducer, initialState: _initalState);
  runApp(MyAPP(store: _store));
}

class MyAPP extends StatelessWidget {
  final Store<AppState> store;
  //#2199e3
  final blue = Color.fromARGB(255, 33, 153, 227);
  // #f05929
  final orange = Color.fromARGB(255, 240, 89, 41);

   MyAPP({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) =>
          ThemeData(
            primaryColor: blue,
            scaffoldBackgroundColor: brightness == Brightness.light
                ? Colors.grey[100]
                : Colors.grey[850],
            accentColor: orange,
            toggleableActiveColor: orange,
            dividerColor:
            brightness == Brightness.light ? Colors.white : Colors.white54,
            brightness: brightness,
            fontFamily: 'PTSans',
            bottomAppBarTheme: Theme
                .of(context)
                .bottomAppBarTheme
                .copyWith(
              elevation: 0,
            ),
            // pageTransitionsTheme: PageTransitionsTheme(
            //   builders: <TargetPlatform, PageTransitionsBuilder>{
            //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            //   },
            // ),
            iconTheme: Theme
                .of(context)
                .iconTheme
                .copyWith(color: orange),
          ),
      themedWidgetBuilder: (context, data) {
        return AnotherProvider(store: store, theme: data);
      },
    );
  }
}

class AnotherProvider extends StatelessWidget {
  final Store<AppState> store;
  final ThemeData theme;

  const AnotherProvider({Key key, this.store, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bishal App',
          theme: theme,
          initialRoute: MCQHomePage.routeName,
          routes: routes,
        )
    );
  }
}


