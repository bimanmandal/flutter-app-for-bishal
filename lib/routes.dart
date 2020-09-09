import 'package:Bishal/ui/screens/about/about_page.dart';
import 'package:Bishal/ui/screens/home/home_page.dart';
import 'package:Bishal/ui/screens/mcq_home/mcq_home_page.dart';
import 'package:Bishal/ui/screens/questions/questions_page.dart';
import 'package:Bishal/ui/screens/settings/settings_page.dart';
import 'package:Bishal/ui/screens/sign_in_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName : (context) => SignInScreen(),
  HomePage.routeName: (context) => HomePage(),
  SettingsPage.routeName: (context) => SettingsPage(),
  AboutPage.routeName: (context) => AboutPage(),
  MCQHomePage.routeName: (context) => MCQHomePage(),
  QuestionsPage.routeName: (context) => QuestionsPage()
};