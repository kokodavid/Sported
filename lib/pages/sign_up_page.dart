import 'package:flutter/material.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/screens/profile_screen.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/services/database.dart';
import 'package:sported_app/widgets/form_input_decoration.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController confirmPassWordTextEditingController = new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {"name": userNameTextEditingController.text, "email": emailTextEditingController.text};

      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passWordTextEditingController.text).then((val) {
        print("$val");

        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                validator: (val) {
                                  return val.isEmpty || val.length < 2 ? "Try another Username" : null;
                                },
                                controller: userNameTextEditingController,
                                style: regularText,
                                decoration: formInputDecoration(hintText: "Full Names")),
                            TextFormField(
                              validator: (val) {
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)
                                    ? null
                                    : "Enter a valid Email";
                              },
                              controller: emailTextEditingController,
                              style: regularText,
                              decoration: formInputDecoration(hintText: "Email"),
                            ),
                            TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  return val.length > 6 ? null : "Please provide a Password with 6+ characters";
                                },
                                controller: passWordTextEditingController,
                                style: regularText,
                                decoration: formInputDecoration(hintText: "Password")),
                            TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  if (val != passWordTextEditingController.text) {
                                    return "Pin not the same";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: confirmPassWordTextEditingController,
                                style: regularText,
                                decoration: formInputDecoration(hintText: "Confirm Password")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Forgot Password ?",
                            style: regularText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [const Color(0xff007EF4), const Color(0xff2A75BC)])),
                          child: Text(
                            "Sign Up",
                            style: regularText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account ?",
                            style: regularText,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Sign In now",
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
    );
  }
}
