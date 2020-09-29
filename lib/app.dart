import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/question/bloc/blocks.dart';
import 'package:Bishal/screens/main_page/home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final orange = Color.fromARGB(255, 240, 89, 41);
  final yellow =  Color(0xffffcc00);
  final blue = Color.fromARGB(255, 33, 153, 227);
  final String title;

  MyApp({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => ThemeData(
        primaryColor: blue,
        scaffoldBackgroundColor: brightness == Brightness.light
            ? Colors.grey[100]
            // ? yellow
            : Colors.grey[850],
            // : Colors.black,
        accentColor: orange,
        toggleableActiveColor: orange,
        dividerColor:
            brightness == Brightness.light ? Colors.white : Colors.white54,
        brightness: brightness,
        fontFamily: 'PTSans',
        bottomAppBarTheme: Theme.of(context).bottomAppBarTheme.copyWith(
              elevation: 0,
            ),
        // pageTransitionsTheme: PageTransitionsTheme(
        //   builders: <TargetPlatform, PageTransitionsBuilder>{
        //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        //   },
        // ),
        iconTheme: Theme.of(context).iconTheme.copyWith(color: orange),
      ),
      themedWidgetBuilder: (context, data) {
        return RepositoryProviders(
          child: BlocProviders(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: data,
              navigatorKey: navigatorKey,
              title: title,
              home: HomePage(
                title: title,
              ),
            ),
          ),
        );
      },
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class VariousProviders extends StatefulWidget {
  final Widget child;

  const VariousProviders({Key key, this.child}) : super(key: key);

  @override
  _VariousProvidersState createState() => _VariousProvidersState();
}

class _VariousProvidersState extends State<VariousProviders> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: widget.child,
    );
  }
}

class RepositoryProviders extends StatelessWidget {
  final Widget child;

  const RepositoryProviders({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ExamRepository(),
      child: child,
    );
  }
}

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final examRepository = RepositoryProvider.of<ExamRepository>(context);

    return BlocProvider(
      create: (context) => QuestionBloc(examRepository),
      child: BlocProvider(
        create: (context) => TestBloc(examRepository, BlocProvider.of<QuestionBloc>(context)),
        child: child,
      ),
    );

    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<TestBloc>(
    //       create: (context) => TestBloc(examRepository),
    //     ),
    //     BlocProvider<QuestionBloc>(
    //       create: (context) => QuestionBloc(examRepository),
    //     )
    //   ],
    //   child: child,
    // );
  }
}
