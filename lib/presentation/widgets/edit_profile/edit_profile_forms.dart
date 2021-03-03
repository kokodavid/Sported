import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/view_controller/user_controller.dart';

import '../../../locator.dart';
import '../../shared/form_input_decoration.dart';

class EditProfileForms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _currentUser = locator.get<UserController>().currentUser;
    final editProfileFormKey = GlobalKey<FormState>();
    TextEditingController fullNameTextEditingController = new TextEditingController();
    TextEditingController emailTextEditingController = new TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Form(
        onChanged: () {},
        key: editProfileFormKey,
        child: Column(
          children: [
            SizedBox(height: 10.0.h),

            //full name title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Full Name',
                style: regularStyle,
              ),
            ),

            SizedBox(height: 10.0.h),

            //full name field
            TextFormField(
              onChanged: (val) {
                // print(val);
                // print(fullNameTextEditingController.text);
              },
              controller: fullNameTextEditingController,
              style: TextStyle(
                fontSize: 15.sp,
                color: Color(0xff707070),
              ),
              decoration: formInputDecoration(
                hintText: "",
                isDense: true,
                // labelText: _currentUser.email,
                prefixIcon: Icons.person_outlined,
              ),
              validator: (val) {
                return val.isEmpty || val.length < 2 ? "Try another Username" : null;
              },
            ),

            SizedBox(height: 20.0.h),

            //email title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: regularStyle,
              ),
            ),

            SizedBox(height: 10.0.h),

            //email field
            TextFormField(
              controller: emailTextEditingController,
              style: regularStyle,
              decoration: formInputDecoration(
                // labelText: _currentUser.email,
                isDense: true,
                hintText: "",
                prefixIcon: Icons.mail_outlined,
              ),
              validator: (val) {
                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter a valid Email";
              },
            ),

            SizedBox(height: 20.0.h),
          ],
        ),
      ),
    );
  }
}
