import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfulBookDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff18181A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0.r)),
      child: Container(
        height: 288.h,
        width: 360.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //tick

            SizedBox(height: 30.h),
            Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff31323B),
              ),
              child: Icon(
                Icons.check,
                size: 32.r,
                color: Color(0xff9BEB81),
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              'Booked Successfully!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              'Your booking is confirmed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),

            Text(
              'See you on {\$bookedTime}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 44.h),

            //done btn
            MaterialButton(
              height: 46.h,
              minWidth: 168.w,
              color: Color(0xff8FD974),
              padding: EdgeInsets.all(0),
              shape: StadiumBorder(),
              elevation: 0.0,
              hoverElevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              focusElevation: 0,
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                ),
              ),
              onPressed: () {
                //TODO: Pop with data
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
