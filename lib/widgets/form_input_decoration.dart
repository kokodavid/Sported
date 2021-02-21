import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration formInputDecoration({String hintText, IconData prefixIcon}) {
  return InputDecoration(
    hintText: hintText,
    alignLabelWithHint: true,
    enabled: true,
    fillColor: Color(0xff31323B),
    filled: true,
    hintStyle: TextStyle(
      fontSize: 12.sp,
      color: Color(0xff707070),
    ),
    prefixIcon: Icon(
      prefixIcon,
      color: Color(0xff8FD974),
      size: 21.r,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
