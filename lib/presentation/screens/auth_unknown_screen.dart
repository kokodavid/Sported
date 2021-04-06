import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthUnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 48.h,
            width: 48.h,
            child: SpinKitFadingCube(
              duration: Duration(milliseconds: 5000),
              color: Color(0xff8FD974),
            ),
          ),
        ),
      ),
    );
  }
}
