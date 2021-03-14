import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/presentation/screens/venue_details_screen.dart';
import 'package:sported_app/presentation/shared/filter_chips/select_sport.dart';

import 'book_screen.dart';

class VenuesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            title: Text(
              'Venues',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //select sports
                SelectSport(),

                //title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 32.w, bottom: 20.h, top: 10.h),
                    child: Text(
                      'Sports Venues Near You',
                      style: regularStyle,
                    ),
                  ),
                ),

                //list of venues
                Padding(
                  padding: EdgeInsets.only(left: 32.w, right: 32.w),
                  child: Container(
                    height: 1.sh,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        //each tile
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => VenueDetailsScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 104.h,
                              padding: EdgeInsets.only(top: 10.h, left: 10.0.w),
                              decoration: BoxDecoration(
                                color: Color(0xff25262B),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //image name sports
                                  Container(
                                    height: 59.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //image
                                        Container(
                                          width: 67.0.w,
                                          height: 59.h,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.r),
                                          ),
                                          child: Image.asset(
                                            'assets/images/stadium.png',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),

                                        SizedBox(width: 8.0.w),

                                        //name & sports
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //name
                                            Text(
                                              'Nairobi Jaffery Sports Club',
                                              style: TextStyle(
                                                fontSize: 15.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff8B8B8B),
                                              ),
                                            ),

                                            //sports
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                //football
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ImageIcon(
                                                      AssetImage('assets/icons/football_icon.png'),
                                                      color: Colors.white,
                                                      size: 18.r,
                                                    ),
                                                    SizedBox(height: 2.0.h),
                                                    Text(
                                                      'Football',
                                                      style: labelStyle.copyWith(fontSize: 9.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 4.w),

                                                //cricket
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ImageIcon(
                                                      AssetImage('assets/icons/cricket_icon.png'),
                                                      color: Colors.white,
                                                      size: 18.r,
                                                    ),
                                                    SizedBox(height: 2.0.h),
                                                    Text(
                                                      'Cricket',
                                                      style: labelStyle.copyWith(fontSize: 9.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 4.w),

                                                //badminton
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ImageIcon(
                                                      AssetImage('assets/icons/badminton_icon.png'),
                                                      color: Colors.white,
                                                      size: 18.r,
                                                    ),
                                                    SizedBox(height: 2.0.h),
                                                    Text(
                                                      'Badminton',
                                                      style: labelStyle.copyWith(fontSize: 9.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 4.w),

                                                //volleyball
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ImageIcon(
                                                      AssetImage('assets/icons/volleyball_icon.png'),
                                                      color: Colors.white,
                                                      size: 18.r,
                                                    ),
                                                    SizedBox(height: 2.0.h),
                                                    Text(
                                                      'Volleyball',
                                                      style: labelStyle.copyWith(fontSize: 9.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 4.w),

                                                //tt
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ImageIcon(
                                                      AssetImage('assets/icons/table_tennis_icon.png'),
                                                      color: Colors.white,
                                                      size: 18.r,
                                                    ),
                                                    SizedBox(height: 2.0.h),
                                                    Text(
                                                      'Table Tennis',
                                                      style: labelStyle.copyWith(fontSize: 9.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 4.w),

                                                SizedBox(width: 20.w),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  //price time book btn
                                  Container(
                                    height: 27.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        //price
                                        Text(
                                          '500 KES/hr',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //time range & book
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //time range
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                //day
                                                Text(
                                                  'Mon - Sun',
                                                  style: labelStyle.copyWith(fontSize: 8.sp),
                                                ),
                                                SizedBox(height: 2.h),

                                                //time
                                                Text(
                                                  '06:00 A.M - 09:00 P.M',
                                                  style: labelStyle.copyWith(fontSize: 8.sp),
                                                ),
                                              ],
                                            ),

                                            SizedBox(width: 7.w),

                                            //book
                                            MaterialButton(
                                              height: 24.h,
                                              minWidth: 69.w,
                                              padding: EdgeInsets.all(0),
                                              elevation: 0.0,
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) => BookScreen(),
                                                  ),
                                                );
                                              },
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              color: Color(0xff8FD974),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.r),
                                                  bottomRight: Radius.circular(8.r),
                                                ),
                                              ),
                                              child: Text(
                                                'Book',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
