import 'package:Bishal/exam/bloc/blocks.dart';
import 'package:Bishal/exam/bloc/exam_cubit.dart';
import 'package:Bishal/exam/repository/exam_repository.dart';
import 'package:Bishal/screens/main_page/home_page.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
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
    return RepositoryProviders(
      child: BlocProviders(
        child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: blue,
                scaffoldBackgroundColor: Colors.grey[850],
                accentColor: orange,
                toggleableActiveColor: orange,
                dividerColor: Colors.white54,
                fontFamily: 'PTSans',
                bottomAppBarTheme: Theme.of(context).bottomAppBarTheme.copyWith(
                  elevation: 0
                ),
                iconTheme: Theme.of(context).iconTheme.copyWith(color: orange)
              ),
              navigatorKey: navigatorKey,
              title: title,
              home: HomePage(
                title: title,
              ),
            ),
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

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
    
    return MultiBlocProvider(
        providers: [
          BlocProvider<ExamCubit>(
            create: (context) => ExamCubit(examRepository),
          )
        ], 
        child: child);

  }
}
