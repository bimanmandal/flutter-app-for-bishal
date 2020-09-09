import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/signIn";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
    );
  }
}
