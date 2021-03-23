import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sported_app/data/services/storage_repo.dart';
import 'package:sported_app/view_controller/user_controller.dart';

import '../../../locator.dart';

class AvatarSection extends StatefulWidget {
  @override
  _AvatarSectionState createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  void getAviUrl() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    String aviUrl = await locator.get<StorageRepo>().getUserProfileImage(uid);
    setState(() {
      avatarUrl = aviUrl;
    });
    print("aviUrl | " + aviUrl);
  }

  @override
  void initState() {
    getAviUrl();
    super.initState();
  }

  File _image;
  String avatarUrl;

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
            child: _image == null
                ? Center(
                    child: avatarUrl == null
                        ? Icon(
                            Icons.person_rounded,
                            color: Color(0xff31323B),
                            size: 155.0.r,
                          )
                        : CircleAvatar(
                            radius: 155.0.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                  )
                : CircleAvatar(
                    radius: 155.0.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: FileImage(_image),
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
              setState(() {
                if (image != null) {
                  _image = File(image.path);
                } else {
                  print('No image selected.');
                }
              });
              await locator.get<UserController>().uploadProfilePicture(_image);

              print("local _image path | " + _image.path.toString());
              print("avatarURl | $avatarUrl");
            },
          ),
        ),

        SizedBox(width: 90.w),
      ],
    );
  }
}
