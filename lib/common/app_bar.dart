import 'package:flutter/material.dart';

class BishalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final imageHeight = 24.0;

  BishalAppBar({Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Theme.of(context).brightness == Brightness.dark
        ? Text("BISHAL", style: TextStyle(color: Colors.white, fontSize: imageHeight),)
        :Text("BISHAL", style: TextStyle(color: Colors.black, fontSize: imageHeight),),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // elevation: 10,
      brightness: Theme.of(context).brightness,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Theme.of(context).accentColor),

    );
  }

  @override
  final Size preferredSize;
}
