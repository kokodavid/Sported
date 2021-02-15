import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/view_controller/user_controller.dart';
import 'package:sported_app/widgets/avatar.dart';
import 'package:sported_app/widgets/manage_profile_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  static String route = "profile-view";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel _currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Avatar(
                    avatarUrl: _currentUser?.avatarUrl,
                    onTap: () async{
                     File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                     await locator.get<UserController>().uploadProfilePicture(image);

                     print(image.path.toString());
                    },
                  ),
                  Text(
                      "Hi ${_currentUser?.displayName ?? 'nice to see you here.'}"),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ManageProfileInfo()
              ))
        ],
      ),
    );
  }
}

