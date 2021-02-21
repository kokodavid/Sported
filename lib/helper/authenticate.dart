import 'package:flutter/material.dart';

import 'file:///D:/LEWY/Dev/Projects/ROUGH/Flutter/SportedApp/lib/pages/sign_in_page.dart';
import 'file:///D:/LEWY/Dev/Projects/ROUGH/Flutter/SportedApp/lib/pages/sign_up_page.dart';

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
      return SignIn(toggle: toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
