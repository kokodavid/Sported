import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';
import 'package:sported_app/presentation/shared/custom_snackbar.dart';
import 'package:sported_app/presentation/widgets/payment/successfully_booked_dialog.dart';

class PaymentScreen extends StatefulWidget {
  final String selectedDate;
  final SportsOffered sportBookingInfo;
  final int selectedSlot;
  final Venue venue;
  final String checkoutId;

  PaymentScreen({
    @required this.selectedDate,
    @required this.selectedSlot,
    @required this.venue,
    @required this.sportBookingInfo,
    @required this.checkoutId,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DocumentReference paymentsRef;
  String mUserMail = "kokodavid78@gmail.com";
  QuerySnapshot payment;
  String navigateBack = 'press confirm';

  updateBookingHistory() {
    final uid = FirebaseAuth.instance.currentUser.uid;
    Map<String, dynamic> bookingHistory = {
      "venueName": widget.venue.venueName,
      "pricePaid": widget.sportBookingInfo.ratesPerHr.toString(),
      "dateBooked": widget.selectedDate,
      "slotBooked": widget.selectedSlot == 0
          ? '0600 hrs'
          : widget.selectedSlot == 1
              ? '0700 hrs'
              : widget.selectedSlot == 2
                  ? '0800 hrs'
                  : widget.selectedSlot == 3
                      ? '0900 hrs'
                      : widget.selectedSlot == 4
                          ? '1000 hrs'
                          : widget.selectedSlot == 5
                              ? '1100 hrs'
                              : widget.selectedSlot == 6
                                  ? '1200 hrs'
                                  : widget.selectedSlot == 7
                                      ? '1300 hrs'
                                      : widget.selectedSlot == 8
                                          ? '1400 hrs'
                                          : widget.selectedSlot == 9
                                              ? '1500 hrs'
                                              : widget.selectedSlot == 10
                                                  ? '1600 hrs'
                                                  : widget.selectedSlot == 11
                                                      ? '1700 hrs'
                                                      : widget.selectedSlot == 12
                                                          ? '1800 hrs'
                                                          : widget.selectedSlot == 13
                                                              ? '1900 hrs'
                                                              : widget.selectedSlot == 14
                                                                  ? '2000 hrs'
                                                                  : widget.selectedSlot == 15
                                                                      ? '2100 hrs'
                                                                      : null,
      "sportName": widget.sportBookingInfo.sportName,
      "uid": uid,
    };

    FirebaseFirestore.instance.collection('booking_history').add(bookingHistory);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: SuccessfulBookDialog(
          // dialogContext:context,
          selectedDate: widget.selectedDate,
          selectedSlot: widget.selectedSlot == 0
              ? '0600 hrs'
              : widget.selectedSlot == 1
                  ? '0700 hrs'
                  : widget.selectedSlot == 2
                      ? '0800 hrs'
                      : widget.selectedSlot == 3
                          ? '0900 hrs'
                          : widget.selectedSlot == 4
                              ? '1000 hrs'
                              : widget.selectedSlot == 5
                                  ? '1100 hrs'
                                  : widget.selectedSlot == 6
                                      ? '1200 hrs'
                                      : widget.selectedSlot == 7
                                          ? '1300 hrs'
                                          : widget.selectedSlot == 8
                                              ? '1400 hrs'
                                              : widget.selectedSlot == 9
                                                  ? '1500 hrs'
                                                  : widget.selectedSlot == 10
                                                      ? '1600 hrs'
                                                      : widget.selectedSlot == 11
                                                          ? '1700 hrs'
                                                          : widget.selectedSlot == 12
                                                              ? '1800 hrs'
                                                              : widget.selectedSlot == 13
                                                                  ? '1900 hrs'
                                                                  : widget.selectedSlot == 14
                                                                      ? '2000 hrs'
                                                                      : widget.selectedSlot == 15
                                                                          ? '2100 hrs'
                                                                          : null,
        ),
      ),
    );
    print({"date | ${widget.selectedDate}"});
  }

  paymentConfirm() async {
    if (await FirebaseFirestore.instance.collection("lost_found_receipts").doc("deposit_info").collection("all").doc(widget.checkoutId).get().then((value) => value.exists == true)) {
      setState(() {
        navigateBack = 'do not navigate back';
      });
      return updateBookingHistory();
    } else {
      setState(() {
        navigateBack = 'navigate back';
      });
      showCustomSnackbar("Payment not successful. You haven\'t booked this slot. Try again", _scaffoldKey);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (navigateBack == "press confirm") {
            showCustomSnackbar('Press Confirm to check the status of your booking', _scaffoldKey);
            return false;
          } else if (navigateBack == 'navigate back') {
            Navigator.pop(context);
            return true;
          }
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
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
                navigateBack == "press confirm"
                    ? showCustomSnackbar('Press Confirm to check the status of your booking', _scaffoldKey)
                    : navigateBack == 'navigate back'
                        ? Navigator.pop(context)
                        : navigateBack == 'do not navigate back'
                            // ignore: unnecessary_statements
                            ? null
                            // ignore: unnecessary_statements
                            : null;

                // Navigator.pop(context);
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
                    // guides

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CONFIRM YOUR BOOKING',
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
                          //1
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
                                  'Wait for MPESA prompt to enter your PIN',
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

                          //2
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
                                  'Enter your PIN to pay for the slot',
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

                          //3
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
                                  'Wait for M-PESA Confirmation Message',
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

                          //4
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
                                  child: RichText(
                                    softWrap: false,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Beware of ',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xBF707070),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "MPESA delays",
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

                          //5
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
                                  child: RichText(
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Press ',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xBF707070),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "CONFIRM BOOKING ",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xBF707070),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'to book your slot.',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Color(0xBF707070),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0.h),

                          //6
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
                                  child: RichText(
                                    softWrap: false,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'NOTE:',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xBF707070),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " Failure to press Confirm Booking will NOT book you a slot",
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

                          //7
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
                                  'View your booking details & history',
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
                        ],
                      ),
                    ),

                    SizedBox(height: 35.h),

                    //proceed btn
                    MaterialButton(
                      height: 40.h,
                      minWidth: 140.w,
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
                        'Confirm Booking',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                      onPressed: () async {
                        await paymentConfirm();
                      },
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
