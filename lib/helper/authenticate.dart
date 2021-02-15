import 'package:flutter/material.dart';
import 'package:sported_app/screens/login.dart';
import 'package:sported_app/screens/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInScreen = true;

  void toggleView() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return Login(toggleView);
    } else {
      return Register(toggleView);
    }
  }
}