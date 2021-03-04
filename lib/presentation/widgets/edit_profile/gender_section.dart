import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/constants/constants.dart';

class GenderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final genderFormKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
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
            key: genderFormKey,
            child: Container(
              width: 170.w,
              child: DropdownButtonFormField(
                elevation: 0,
                iconSize: 23.r,
                onChanged: (_) {},
                isDense: true,
                isExpanded: true,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xff8FD974),
                ),
                items: [
                  //TODO: Implement gender selection
                  DropdownMenuItem(
                    child: SizedBox(
                      width: 122.w,
                      child: Text(
                        "Male",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    child: SizedBox(
                      width: 122.w,
                      child: Text(
                        "Female",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  DropdownMenuItem(
                    child: SizedBox(
                      width: 122.w,
                      child: Text(
                        "Other",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
                hint: SizedBox(
                  width: 122.w,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select your Gender',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Color(0xff8FD974),
                      ),
                    ),
                  ),
                ),
                icon: Icon(
                  MdiIcons.chevronDown,
                  size: 24.r,
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
