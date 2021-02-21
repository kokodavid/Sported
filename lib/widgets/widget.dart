import 'package:flutter/material.dart';

Widget appBarMain(BuildContext buildContext) {
  return AppBar(
    title: Text("SPORTED"),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}
