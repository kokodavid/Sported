import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/business_logic/blocs/nav_bloc/nav_bloc.dart';
import 'package:sported_app/data/services/auth.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/presentation/shared/form_input_decoration.dart';
import 'package:sported_app/presentation/shared/pages_switcher.dart';
import 'package:sported_app/view_controller/user_controller.dart';

class SignInPage extends StatefulWidget {
  final Function toggle;
  SignInPage({this.toggle});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isSubmitting;
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthMethods authMethods = AuthMethods();
  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    Widget loadingIndicator = _isLoading
        ? new Container(
            color: Color(0xff18181A),
            width: 70.0,
            height: 70.0,
            child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(
                child: new LinearProgressIndicator(
                  backgroundColor: Color(0xff8FD974),
                ),
              ),
            ),
          )
        : new Container();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(top: 20.0.h, left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title
                SizedBox(height: 25.h),
                Text(
                  'SPORTED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0.sp,
                    color: Colors.white,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 40.h),

                //sign in
                Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30.h),

                //welcome back
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff8FD974),
                  ),
                ),

                SizedBox(height: 30.h),

                //form
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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

                      SizedBox(height: 10.0.h),

                      //email field
                      TextFormField(
                        controller: emailTextEditingController,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff707070),
                        ),
                        decoration: formInputDecoration(
                          hintText: "company@example.com",
                          prefixIcon: Icons.mail_outlined,
                        ),
                        validator: (val) {
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter a valid Email";
                        },
                      ),

                      SizedBox(height: 20.0.h),

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

                      SizedBox(height: 10.0.h),

                      //password field
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.length > 6 ? null : "Please provide a Password with 6+ characters";
                        },
                        controller: passWordTextEditingController,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff707070),
                        ),
                        decoration: formInputDecoration(
                          hintText: "Password",
                          prefixIcon: Icons.lock_outlined,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                //reset password
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "Reset Password",
                //     style: TextStyle(
                //       fontSize: 15.0.sp,
                //       color: Color(0xff8FD974),
                //     ),
                //   ),
                // ),

                SizedBox(height: 24.h),
                new Align(
                  child: loadingIndicator,
                  alignment: FractionalOffset.topCenter,
                ),

                //sign in btn
                MaterialButton(
                  color: Color(0xff8FD974),
                  shape: StadiumBorder(),
                  minWidth: 1.sw,
                  height: 50.h,
                  onPressed: () {
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    login();
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20.0.h),

                //social sign in
                // Text(
                //   'Or Sign In using',
                //   style: regularStyle,
                // ),
                //
                // SizedBox(height: 15.0.h),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     //facebook
                //     MaterialButton(
                //       onPressed: () {},
                //       padding: EdgeInsets.symmetric(horizontal: 8.r),
                //       splashColor: Colors.transparent,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           CircleAvatar(
                //             radius: 19.r,
                //             backgroundColor: Colors.transparent,
                //             child: Image.asset(
                //               'assets/icons/facebook_icon.png',
                //               height: 19.r,
                //               width: 19.r,
                //             ),
                //           ),
                //           SizedBox(width: 4.w),
                //           Text('Facebook', style: regularStyle),
                //         ],
                //       ),
                //     ),
                //
                //     //google
                //     MaterialButton(
                //       onPressed: () {
                //         Navigator.pushReplacement(
                //             context, MaterialPageRoute(builder: (context) => HomePage()));
                //       },
                //       padding: EdgeInsets.symmetric(horizontal: 8.r),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             backgroundColor: Colors.transparent,
                //             child: Image.asset(
                //               'assets/icons/google_icon.png',
                //               height: 19.r,
                //               width: 19.r,
                //             ),
                //           ),
                //           SizedBox(width: 4.w),
                //           Text('Google', style: regularStyle),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                //sign up cta
                SizedBox(height: 45.h),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff707070),
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () async => await widget.toggle(),
                        text: 'Sign Up',
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

                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() {
    if (formKey.currentState.validate()) {
      _LoginUser();
    }
  }

  _LoginUser() async {
    setState(() {
      _isSubmitting = true;
      _isLoading = true;
    });

    final logMessage = await locator.get<UserController>().signInWithEmailAndPassword(email: emailTextEditingController.text, password: passWordTextEditingController.text);

    logMessage == "Logged In Successfully" ? _showSuccessSnack(logMessage) : _showErrorSnack(logMessage);

    //print("I am logMessage $logMessage");

    if (logMessage == "Logged In Successfully") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider<NavBloc>(
            create: (context) => NavBloc()..add(LoadPageThree()),
            child: PagesSwitcher(),
          ),
        ),
      );

      return;
    } else {
      setState(() {
        _isSubmitting = false;
        _isLoading = false;
      });
    }
  }

  // login() async{
  //   try {
  //      await locator
  //         .get<UserController>()
  //         .signInWithEmailAndPassword(
  //       email: emailTextEditingController.text,
  //       password: passWordTextEditingController.text,
  //     );
  //      Navigator.pushReplacement(context, MaterialPageRoute(
  //          builder: (context) => HomePage()
  //      ));
  //
  //     } catch (e) {
  //   }
  // }

  _showSuccessSnack(String message) async {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xffd0e9c8),
      duration: Duration(milliseconds: 2000),
      content: Text(
        "$message",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.hideCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackbar);
    formKey.currentState.reset();
  }

  _showErrorSnack(String message) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xffd0e9c8),
      duration: Duration(milliseconds: 2000),
      content: Text(
        "$message",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.hideCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackbar);
    setState(() {
      _isSubmitting = false;
    });
  }
}
