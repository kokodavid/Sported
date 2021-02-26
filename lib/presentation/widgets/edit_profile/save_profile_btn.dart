import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/view_controller/user_controller.dart';

class SaveProfileBtn extends StatelessWidget {
  String _name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //btn
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 30.h,
              color: Color(0xff8FD974),
              minWidth: 112.w,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0.0,
              hoverElevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              focusElevation: 0,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                ),
              ),
              onPressed: () {
                //TODO: Implement save profile
                return createUserProfile();

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) =>
                //         BlocProvider<NavBloc>(
                //           create: (context) =>
                //           NavBloc()
                //             ..add(LoadPageThree()),
                //           child: PagesSwitcher(),
                //         ),
                //   ),
                // );
              },
            ),
          ],
        ),

        SizedBox(height: 20.0.h),
      ],
    );
  }

  createUserProfile() async {
    try {
      _name = await getStringValuesSF();
      await locator.get<UserController>().uploadProfile(fullName: _name);
      print(_name);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic getStringValuesSF() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _prefs;
    String _res = preferences.getString("name");
    //Return String
    return _res;
  }
}
