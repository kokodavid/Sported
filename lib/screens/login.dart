import 'package:flutter/material.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/screens/profile_screen.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/view_controller/user_controller.dart';
import 'package:sported_app/widgets/widget.dart';

class Login extends StatefulWidget {
  final Function toggle;
  Login(this.toggle);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();

  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  login() async {
    try {
      await locator.get<UserController>().signInWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: passWordTextEditingController.text,
          );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    } catch (e) {
      print("Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      validator: (val) {
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)
                            ? null
                            : "Enter a valid Email";
                      },
                      controller: emailTextEditingController,
                      style: simpleTextStyle,
                      decoration: textFieldInputDecoration("Email")),
                  TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.length > 6 ? null : "Please provide a Password with 6+ characters";
                      },
                      controller: passWordTextEditingController,
                      style: simpleTextStyle,
                      decoration: textFieldInputDecoration("Password")),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forgot Password ?",
                        style: mediumTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [const Color(0xff007EF4), const Color(0xff2A75BC)])),
                      child: Text(
                        "Sign In",
                        style: mediumTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account ?",
                        style: mediumTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Register now",
                            style: TextStyle(color: Colors.white, fontSize: 17, decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
