import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sported_app/presentation/screens/payment_screen.dart';
import 'package:sported_app/presentation/shared/filter_chips/select_sport.dart';
import 'package:sported_app/presentation/widgets/book/pick_date.dart';
import 'package:sported_app/presentation/widgets/book/pick_slots.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff18181A),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 18.r,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Book',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            //select sports
            SelectSport(),

            SizedBox(height: 20.h),

            //calendar
            PickDate(),

            //slots
            PickSlots(),

            SizedBox(height: 24.h),

            //pay btn
            MaterialButton(
              height: 40.h,
              minWidth: 88.w,
              color: Color(0xff8FD974),
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0.0,
              hoverElevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              focusElevation: 0,
              child: Text(
                'Pay',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return PaymentScreen();
                  }),
                );
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
