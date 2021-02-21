import 'package:flutter/material.dart';

InputDecoration formInputDecoration({String hintText, IconData prefixIcon}) {
  return InputDecoration(
    hintText: hintText,
    fillColor: Color(0xff31323B),
    filled: true,
    hintStyle: TextStyle(
      fontSize: 12,
      color: Color(0xff707070),
    ),
    prefixIcon: Icon(
      prefixIcon,
      color: Color(0xff8FD974),
      size: 21,
    ),
    alignLabelWithHint: true,
    enabled: true,
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
