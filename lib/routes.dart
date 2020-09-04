import 'package:Bishal/screens/about/about_page.dart';
import 'package:Bishal/screens/home/home_page.dart';
import 'package:Bishal/screens/settings/settings_page.dart';
import 'package:Bishal/screens/sign_in_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName : (context) => SignInScreen(),
  HomePage.routeName: (context) => HomePage(),
  SettingsPage.routeName: (context) => SettingsPage(),
  AboutPage.routeName: (context) => AboutPage()
};