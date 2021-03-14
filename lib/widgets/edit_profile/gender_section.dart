import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/constants/constants.dart';

class GenderSection extends StatelessWidget {
  String age;
  @override
  Widget build(BuildContext context) {
    final ageFormKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //age title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Gender',
              style: regularStyle,
            ),
          ),

          //age range dropdown
          SizedBox(height: 10.0.h),
          Form(
            key: ageFormKey,
            child: Container(
              width: 170.w,
              child: DropdownButtonFormField(
                elevation: 0,
                iconSize: 1.r,
                onChanged: (val) {

                },
                isDense: true,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xff8FD974),
                ),
                items: ['Male', 'Female', 'Other'].map(
                      (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                hint: age == null ? Text('Gender',style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xff8FD974),
                ),):Text(age),
                icon: Icon(
                  MdiIcons.chevronDown,
                  size: 15.r,
                  color: Color(0xffC5C6C7),
                ),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  enabled: true,
                  fillColor: Color(0xff31323B),
                  filled: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0.h),
        ],
      ),
    );
  }
}
