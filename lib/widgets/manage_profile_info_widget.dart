import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: "Username"),
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              TextFormField(
                decoration:
                InputDecoration(hintText: "New Password"),
              ),
              TextFormField(
                decoration:
                InputDecoration(hintText: "Repeat Password"),
              )
            ],
          ),
        ),
        RaisedButton(
          onPressed: () {
            // TODO: Save somehow
            Navigator.pop(context);
          },
          child: Text("Save Profile"),
        )
      ],
    );
  }
}
