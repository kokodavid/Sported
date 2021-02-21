import 'package:flutter/material.dart';
import 'package:sported_app/pages/sign_in_page.dart';
import 'package:sported_app/pages/sign_up_page.dart';

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
      return SignInPage(toggle: toggleView);
    } else {
      return SignUpPage(toggle: toggleView);
    }
  }
}
