import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/constants/constants.dart';

import 'file:///D:/LEWY/Dev/Projects/ROUGH/Flutter/SportedApp/lib/helper/form_input_decoration.dart';

class CoachingPrompt extends StatefulWidget {
  @override
  _CoachingPromptState createState() => _CoachingPromptState();
}

class _CoachingPromptState extends State<CoachingPrompt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //padded content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Are you able to train someone who is looking to learn?',
                    style: regularStyle,
                  ),
                ),

                SizedBox(height: 10.0.h),

                //btns
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //yes
                    MaterialButton(
                      height: 30.h,
                      color: Color(0xff8FD974),
                      minWidth: 56.w,
                      padding: EdgeInsets.all(0),
                      shape: StadiumBorder(),
                      elevation: 0.0,
                      hoverElevation: 0,
                      disabledElevation: 0,
                      highlightElevation: 0,
                      focusElevation: 0,
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                      ),
                      onPressed: () {},
                    ),

                    SizedBox(width: 12.0.w),

                    //no
                    MaterialButton(
                      height: 30.h,
                      color: Color(0xff31323B),
                      minWidth: 56.w,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Color(0xff3E3E3E),
                        ),
                      ),
                      padding: EdgeInsets.all(0),
                      elevation: 0.0,
                      hoverElevation: 0,
                      disabledElevation: 0,
                      highlightElevation: 0,
                      focusElevation: 0,
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Color(0xff707070),
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                SizedBox(height: 10.0.h),

                //etc
                RichText(
                  text: TextSpan(
                    text: 'Do you hold any certifications or credentials to be able to coach?',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Color(0xff8FD974),
                    ),
                    children: [
                      TextSpan(
                        text: ' If you do, please share a link to your portfolio.',
                        style: hintStyle.copyWith(fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.0.h),

                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: TextFormField(
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 15.sp,
                    ),
                    decoration: formInputDecoration(
                      isDense: true,
                      hintText: 'Paste URL',
                      prefixIcon: Icons.link,
                    ),
                  ),
                ),

                SizedBox(height: 20.0.h),
              ],
            ),
          ),

          //divider
          Divider(height: 1.h, thickness: 1.0.h, color: Color(0xff2E2D2D)),

          SizedBox(height: 20.0.h),
        ],
      ),
    );
  }
}
