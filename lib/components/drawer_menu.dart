import 'package:Bishal/screens/about/about_page.dart';
import 'package:Bishal/screens/home/home_page.dart';
import 'package:Bishal/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
            child: Center(
              child: Text("REDUX",
              style: TextStyle(fontSize: Theme.of(context).textTheme.headline3.fontSize),),
            ),
          ),
          ListTile(title: Text("Home"), onTap: () => Navigator.pushReplacementNamed(context, HomePage.routeName),),
          SizedBox(height: 0.5,child: Container(color: Colors.grey,),),
          ListTile(title: Text("About"), onTap: () => Navigator.pushReplacementNamed(context, AboutPage.routeName),),
          SizedBox(height: 0.5,child: Container(color: Colors.grey,),),
          ListTile(title: Text("Settings"), onTap: () => Navigator.pushReplacementNamed(context, SettingsPage.routeName),),
        ],
      ),
    );
  }
}
