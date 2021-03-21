import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';
import 'package:sported_app/presentation/shared/form_input_decoration.dart';
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
    @required this.checkoutId
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DocumentReference paymentsRef;
  String mUserMail = "kokodavid78@gmail.com";
  QuerySnapshot payment;


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
      builder: (_) => SuccessfulBookDialog(
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
    );
  }

  paymentConfirm()async{
    if(await FirebaseFirestore.instance.collection("lost_found_receipts").doc("deposit_info").collection("all").doc(widget.checkoutId).get().then(
            (value) => value.exists == true)){
      _showErrorSnackbar("Money");
      updateBookingHistory();
    }else{
      _showErrorSnackbar("Error No Money");

    }


    // print(await FirebaseFirestore.instance.collection("lost_found_receipts").doc("deposit_info").collection("all").doc(widget.checkoutId).get());



  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  // title

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
                      'Pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                    onPressed: () async{
                      //TODO:STKPush
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
    );
  }
  _showErrorSnackbar(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        "$message",
        style: TextStyle(color: Colors.red),
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.hideCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

}


