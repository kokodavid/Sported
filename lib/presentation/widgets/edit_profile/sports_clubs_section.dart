import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/constants/constants.dart';

class SportsClubsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String club1,club2,club3;
    final sportsClubKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          //title
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Are you a member of a sports club?',
              style: regularStyle,
            ),
          ),
          SizedBox(height: 10.h),

          //forms
          Form(
            key: sportsClubKey,
            child: Column(
              children: [
                //club 1
                DropdownButtonFormField(
                  elevation: 0,
                  iconSize: 23.r,
                  isDense: true,
                  isExpanded: false,
                  hint: club1 == null ? Text('Please select a sports club',style: labelStyle):Text(club1),
                  icon: Icon(
                    MdiIcons.chevronDown,
                    color: Color(0xffC5C6C7),
                  ),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color(0xff8FD974),
                  ),
                  items: ['NJSC', 'Karen tennis', 'Aga khan','Oshwal Centre','Jaffery Turf','Arena One','Gym Khana','Sikh Union','Parklands Sports club','Impala Club'].map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  decoration: InputDecoration(
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
                  onChanged: (val) {},
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  elevation: 0,
                  iconSize: 23.r,
                  isDense: true,
                  isExpanded: false,
                  hint: club2 == null ? Text('Please select a sports club',style: labelStyle):Text(club1),
                  icon: Icon(
                    MdiIcons.chevronDown,
                    color: Color(0xffC5C6C7),
                  ),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color(0xff8FD974),
                  ),
                  items: ['NJSC', 'Karen tennis', 'Aga khan','Oshwal Centre','Jaffery Turf','Arena One','Gym Khana','Sikh Union','Parklands Sports club','Impala Club'].map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  decoration: InputDecoration(
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
                  onChanged: (_) {},
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  elevation: 0,
                  iconSize: 23.r,
                  isDense: true,
                  isExpanded: false,
                  hint: club2 == null ? Text('Please select a sports club',style: labelStyle):Text(club1),
                  icon: Icon(
                    MdiIcons.chevronDown,
                    color: Color(0xffC5C6C7),
                  ),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color(0xff8FD974),
                  ),
                  items: ['NJSC', 'Karen tennis', 'Aga khan','Oshwal Centre','Jaffery Turf','Arena One','Gym Khana','Sikh Union','Parklands Sports club','Impala Club'].map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  decoration: InputDecoration(
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
                  onChanged: (_) {},
                ),
                SizedBox(height: 20),
                //divider
                Divider(height: 1.h, thickness: 1.0.h, color: Color(0xff2E2D2D)),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
