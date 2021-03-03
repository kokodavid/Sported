import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/presentation/shared/form_input_decoration.dart';
import 'package:sported_app/presentation/widgets/payment/successfully_booked_dialog.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff18181A),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: KeyboardAvoider(
            autoScroll: true,
            focusPadding: 40.h,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 40.h),
                  //banner
                  Container(
                    height: 100.h,
                    width: 1.sw,
                    child: Image.asset(
                      'assets/images/mpesa_banner.png',
                      width: 190.w,
                    ),
                  ),

                  SizedBox(height: 80.h),

                  //invoice number
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Invoice Number #2342343',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'LIPA NA MPESA',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  //guides
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: Text(
                                'Go to Safaricom Menu',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xBF707070),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: Text(
                                'Select M-PESA',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xBF707070),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: Text(
                                'Select LIPA NA M-PESA',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xBF707070),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: Text(
                                'Select Buy Goods and Services',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xBF707070),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: SizedBox(
                                width: 330.w,
                                //TODO: Confirm Till Number
                                child: RichText(
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: 'Enter the TILL N0: ',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xBF707070),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "972946",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xBF707070),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: SizedBox(
                                width: 330.w,
                                //TODO: Confirm Till Number
                                child: RichText(
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: 'Enter the AMOUNT: ',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xBF707070),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "2600",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xBF707070),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0.h),
                        Row(
                          children: [
                            //indicator
                            Icon(
                              MdiIcons.circleOutline,
                              size: 10.r,
                              color: Color(0xff9BEB81),
                            ),

                            SizedBox(width: 10.w),

                            //guide
                            SizedBox(
                              width: 330.w,
                              child: Text(
                                'CONFIRM',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xBF707070),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  //title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 374.w,
                      child: Text(
                        'Enter the transaction code you received from M-PESA',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  //txt box
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,

                    //TODO: Validate transaction code
                    child: TextFormField(
                      maxLines: 1,
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 15.sp,
                      ),
                      decoration: formInputDecoration(
                        isDense: true,
                        hintText: 'Enter transaction code',
                        prefixIcon: MdiIcons.numeric,
                      ),
                    ),
                  ),

                  SizedBox(height: 35.h),

                  //proceed btn
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
                      'Proceed',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                    onPressed: () {
                      //TODO: Validate transaction code
                      //TODO: Add to bookings history
                      showDialog(
                        context: context,
                        builder: (_) => SuccessfulBookDialog(),
                      );
                    },
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
