import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/view_controller/user_controller.dart';

import '../../locator.dart';
import 'avatar.dart';

class AvatarSection extends StatefulWidget {
  @override
  _AvatarSectionState createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  UserModel _currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 129.w),
        //avi
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 117.h,
            width: 155.w,
            color: Colors.transparent,
            child: Avatar(
              avatarUrl: _currentUser?.avatarUrl,
            ),
          ),
        ),

        SizedBox(width: 18.w),

        //pick image
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            padding: EdgeInsets.all(0),
            constraints: BoxConstraints(
              minWidth: 20.w,
              maxWidth: 20.w,
              maxHeight: 20.h,
              minHeight: 20.h,
            ),
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 20.r,
              color: Colors.white,
            ),
            onPressed: () async {
              // ignore: deprecated_member_use
              File image = await ImagePicker.pickImage(source: ImageSource.gallery);
              await locator.get<UserController>().uploadProfilePicture(image);
              print(image.path.toString());
            },
          ),
        ),

        SizedBox(width: 90.w),
      ],
    );
  }
}
