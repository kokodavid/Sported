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
  PaymentScreen({
    @required this.selectedDate,
    @required this.selectedSlot,
    @required this.venue,
    @required this.sportBookingInfo,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  DocumentReference paymentsRef;
  String mUserMail = "kokodavid78@gmail.com";
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });

      paymentsRef =
          FirebaseFirestore.instance.collection('payments').doc(mUserMail);
    } catch (e) {
      print(e.toString());
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }


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


  Future<void> updateAccount(String mCheckoutRequestID) {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
    };

    paymentsRef.set({"info": "$mUserMail receipts data goes here."});

    return paymentsRef
        .collection("deposit")
        .doc(mCheckoutRequestID)
        .set(initData)
        .then((value) => print("Transaction Initialized."))
        .catchError((error) => print("Failed to init transaction: $error"));
  }

  Future<dynamic> startTransaction({double amount, String phone})async{
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    try {
      //Run it
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: phone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https",
              host : "us-central1-sportedapp-6f6d2.cloudfunctions.net",
              path: "paymentCallback"
          ),
          accountReference: "payment",
          phoneNumber: phone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "Demo",
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      var result = transactionInitialisation as Map<String, dynamic>;

      if (result.keys.contains("ResponseCode")) {
        String mResponseCode = result["ResponseCode"];
        print("Resulting Code: " + mResponseCode);
        if (mResponseCode == '0') {
          updateAccount(result["CheckoutRequestID"]);
        }
      }
      print("RESULT: " + transactionInitialisation.toString());

    } catch (e) {
      //you can implement your exception handling here.
      //Network unreachability is a sure exception.
      print("Exception Caught: " + e.toString());
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

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
                    onPressed: () async{
                      //TODO:STKPush
                      await startTransaction(amount: 1,phone: "254708207512");
                      // updateBookingHistory();
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
