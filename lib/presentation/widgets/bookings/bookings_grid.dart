import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BookingsGrid extends StatelessWidget {
  final List<String> sportsIcons = [
    'assets/icons/football_icon.png',
    'assets/icons/football_icon.png',
    'assets/icons/cricket_icon.png',
    'assets/icons/cricket_icon.png',
    'assets/icons/handball_icon.png',
    'assets/icons/handball_icon.png',
    'assets/icons/table_tennis_icon.png',
  ];

  final List<String> sportsVenues = [
    'Nairobi Jaffery Sports Club',
    'Nairobi Jaffery Sports Club',
    'Nairobi Jaffery Sports Club',
    'Nairobi Jaffery Sports Club',
    'Nairobi Jaffery Sports Club',
    'Nairobi Jaffery Sports Club',
    'Nairobi Jaffery Sports Club',
  ];

  final List<String> bookedTimes = [
    '8:00 A.M',
    '9:00 A.M',
    '6:00 P.M',
    '6:00 P.M',
    '6:00 P.M',
    '8:00 A.M',
    '4:00 P.M',
  ];
  final List<String> bookedDates = [
    'Wed 12 Jun 2021',
    'Mon 2 Jan 2021',
    'Mon 2 Jan 2021',
    'Fri 1 Jul 2021',
    'Sun 2 Apr 2021',
    'Sun 2 Apr 2021',
    'Sat 3 Apr 2021',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 7,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.w,
        ),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: 176.w,
            height: 216.h,
            padding: EdgeInsets.all(12.0.r),
            decoration: BoxDecoration(
              color: Color(0xff25262C),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //sports icon
                ImageIcon(
                  AssetImage(
                    sportsIcons[index],
                  ),
                  color: Colors.white,
                  size: 72.r,
                ),

                SizedBox(height: 14.h),

                //venue
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    sportsVenues[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff8FD974),
                      fontSize: 13.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                //date
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //icon
                    Icon(
                      Icons.event_note,
                      color: Color(0xff9BEB81),
                      size: 12.r,
                    ),

                    SizedBox(width: 16.w),

                    // date
                    Text(
                      bookedDates[index],
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),
                // time
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //icon
                    Icon(
                      MdiIcons.clockTimeThreeOutline,
                      color: Color(0xff9BEB81),
                      size: 12.r,
                    ),

                    SizedBox(width: 16.w),

                    // date
                    Text(
                      bookedTimes[index],
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
