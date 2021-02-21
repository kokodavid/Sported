import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/screens/profile_screen.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/services/database.dart';
import 'package:sported_app/widgets/form_input_decoration.dart';

class SignUpPage extends StatefulWidget {
  final Function toggle;
  SignUpPage({this.toggle});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff8FD974),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0.h, left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
                  child: Column(
                    children: [
                      //sign in
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      //welcome
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome to Sported!',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff8FD974),
                          ),
                        ),
                      ),

                      SizedBox(height: 25.h),

                      //form
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //full name title
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                  color: Color(0xffBBBBBC),
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0.h),

                            //full name field
                            TextFormField(
                              controller: userNameTextEditingController,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xff707070),
                              ),
                              decoration: formInputDecoration(
                                hintText: "Full Name",
                                prefixIcon: Icons.person_outlined,
                              ),
                              validator: (val) {
                                return val.isEmpty || val.length < 2 ? "Try another Username" : null;
                              },
                            ),
                            SizedBox(height: 16.0.h),

                            //email title
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  color: Color(0xffBBBBBC),
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0.h),

                            //email field
                            TextFormField(
                              controller: emailTextEditingController,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xff707070),
                              ),
                              decoration: formInputDecoration(
                                hintText: "Email",
                                prefixIcon: Icons.mail_outlined,
                              ),
                              validator: (val) {
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)
                                    ? null
                                    : "Enter a valid Email";
                              },
                            ),
                            SizedBox(height: 16.0.h),

                            //password title
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  color: Color(0xffBBBBBC),
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0.h),

                            //password field
                            TextFormField(
                              obscureText: true,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xff707070),
                              ),
                              decoration: formInputDecoration(
                                hintText: "Password",
                                prefixIcon: Icons.lock_outlined,
                              ),
                              validator: (val) {
                                return val.length > 6 ? null : "Please provide a Password with 6+ characters";
                              },
                              controller: passWordTextEditingController,
                            ),
                            SizedBox(height: 16.0.h),

                            //confirm password title
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Confirm Password',
                                style: TextStyle(
                                  color: Color(0xffBBBBBC),
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0.h),

                            //confirm password field
                            TextFormField(
                              obscureText: true,
                              controller: confirmPassWordTextEditingController,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xff707070),
                              ),
                              decoration: formInputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: Icons.lock_outlined,
                              ),
                              validator: (val) {
                                if (val != passWordTextEditingController.text) {
                                  return "Passwords do not match";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 16.0.h),
                          ],
                        ),
                      ),

                      SizedBox(height: 80.h),

                      //sign up btn
                      MaterialButton(
                        color: Color(0xff8FD974),
                        shape: StadiumBorder(),
                        minWidth: 1.sw,
                        height: 50.h,
                        onPressed: () {
                          signMeUp();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 56.h),

                      //sign in cta
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xff707070),
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () async => await widget.toggle(),
                              text: 'Sign In',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Color(0xff8FD974),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
