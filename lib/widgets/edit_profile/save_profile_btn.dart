import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/business_logic/blocs/nav_bloc/nav_bloc.dart';
import 'package:sported_app/shared/pages_switcher.dart';

class SaveProfileBtn extends StatelessWidget {
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider<NavBloc>(
                      create: (context) => NavBloc()..add(LoadPageThree()),
                      child: PagesSwitcher(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),

        SizedBox(height: 20.0.h),
      ],
    );
  }
}
