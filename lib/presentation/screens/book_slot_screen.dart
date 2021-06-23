import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:sported_app/business_logic/blocs/filter_bloc/filter_bloc.dart';
import 'package:sported_app/business_logic/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/data/models/UserProfile.dart';
import 'package:sported_app/data/models/booking/booking_history_model.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';
import 'package:sported_app/data/repositories/booking_history_data_provider.dart';
import 'package:sported_app/presentation/screens/payment_screen.dart';
import 'package:sported_app/presentation/shared/custom_snackbar.dart';
import 'package:sported_app/presentation/widgets/payment/successfully_booked_dialog.dart';

class BookSlotScreen extends StatefulWidget {
  final sportBookingInfo;
  final List<BookingHistory> entireBookingHistory;
  final Venue venue;
  final selectedDate;
  final BookingHistoryDataProvider bookingHistoryDataProvider;

  const BookSlotScreen({
    Key key,
    this.entireBookingHistory,
    @required this.venue,
    @required this.sportBookingInfo,
    this.bookingHistoryDataProvider,
    this.selectedDate,
  }) : super(key: key);

  @override
  _BookSlotScreenState createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {
  TextEditingController phoneNumber = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedSlot;
  bool isBooked = false;
  bool isCheckingAvailability = false;
  String convertedSlot;
  DocumentReference paymentsRef;
  String mUserMail = "kokodavid78@gmail.com";
  String checkoutId;
  UserProfile userProfile;
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });

      paymentsRef = FirebaseFirestore.instance.collection('payments').doc(mUserMail);
    } catch (e) {
      print(e.toString());
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  Future<void> updateAccount(String mCheckoutRequestID) {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
    };

    paymentsRef.set({"info": "$mUserMail receipts data goes here."});

    return paymentsRef.collection("deposit").doc(mCheckoutRequestID).set(initData).then((value) => print("Transaction Initialized.")).catchError((error) => print("Failed to init transaction: $error"));
  }

  Future<dynamic> startTransaction({double amount, String phone}) async {
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: phone,
          partyB: "174379",
          callBackURL: Uri(scheme: "https", host: "us-central1-sportedapp-6f6d2.cloudfunctions.net", path: "paymentCallback"),
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
          setState(() {
            checkoutId = result["CheckoutRequestID"];
          });
        }
      }
      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      //you can implement your exception handling here.
      //Network unreachability is a sure exception.
      print("Exception Caught: " + e.toString());
    }
  }

  List compareTime = [
    6,
    6.5,
    7,
    7.5,
    8,
    8.5,
    9,
    9.5,
    10,
    10.5,
    11,
    11.5,
    12,
    12.5,
    13,
    13.5,
    14,
    14.5,
    15,
    15.5,
    16,
    16.5,
    17,
    17.5,
    18,
    18.5,
    19,
    19.5,
    20,
    20.5,
    21,
    21.5,
  ];
  List<String> slots = [
    '6 - 7 AM',
    '6:30 -\n7:30 AM',
    '7 - 8 AM',
    '7:30 -\n8:30 AM',
    '8 - 9 AM',
    '8:30 -\n9:30 AM',
    '9 - 10 AM',
    '9:30 -\n10:30 AM',
    '10 - 11 AM',
    '10:30 -\n11:30 AM',
    '11 - 12 PM',
    '11:30 -\n12:30 PM',
    '12 - 1 PM',
    '12:30 -\n1:30 PM',
    '1 - 2 PM',
    '1:30 -\n2:30 PM',
    '2 - 3 PM',
    '2:30 -\n3:30 PM',
    '3 - 4 PM',
    '3:30 -\n4:30 PM',
    '4 - 5 PM',
    '4:30 -\n5:30 PM',
    '5 - 6 PM',
    '5:30 -\n6:30 PM',
    '6 - 7 PM',
    '6:30 -\n7:30 PM',
    '7 - 8 PM',
    '7:30 -\n8:30 PM',
    '8 - 9 PM',
    '8:30 -\n9:30 PM',
    '9 - 10 PM',
    '9:30 -\n10:30 PM',
  ];

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  updateBookingHistory() {
    final selectedDateTime = DateTime.parse(widget.selectedDate);
    final String bookedDateTime = selectedSlot == 0
        ? selectedDateTime.add(Duration(hours: 6)).toString()
        : selectedSlot == 1
            ? selectedDateTime.add(Duration(hours: 6, minutes: 30)).toString()
            : selectedSlot == 2
                ? selectedDateTime.add(Duration(hours: 7)).toString()
                : selectedSlot == 3
                    ? selectedDateTime.add(Duration(hours: 7, minutes: 30)).toString()
                    : selectedSlot == 4
                        ? selectedDateTime.add(Duration(hours: 8)).toString()
                        : selectedSlot == 5
                            ? selectedDateTime.add(Duration(hours: 8, minutes: 30)).toString()
                            : selectedSlot == 6
                                ? selectedDateTime.add(Duration(hours: 9)).toString()
                                : selectedSlot == 7
                                    ? selectedDateTime.add(Duration(hours: 9, minutes: 30)).toString()
                                    : selectedSlot == 8
                                        ? selectedDateTime.add(Duration(hours: 10)).toString()
                                        : selectedSlot == 9
                                            ? selectedDateTime.add(Duration(hours: 10, minutes: 30)).toString()
                                            : selectedSlot == 10
                                                ? selectedDateTime.add(Duration(hours: 11)).toString()
                                                : selectedSlot == 11
                                                    ? selectedDateTime.add(Duration(hours: 11, minutes: 30)).toString()
                                                    : selectedSlot == 12
                                                        ? selectedDateTime.add(Duration(hours: 12)).toString()
                                                        : selectedSlot == 13
                                                            ? selectedDateTime.add(Duration(hours: 12, minutes: 30)).toString()
                                                            : selectedSlot == 14
                                                                ? selectedDateTime.add(Duration(hours: 13)).toString()
                                                                : selectedSlot == 15
                                                                    ? selectedDateTime.add(Duration(hours: 13, minutes: 30)).toString()
                                                                    : selectedSlot == 16
                                                                        ? selectedDateTime.add(Duration(hours: 14)).toString()
                                                                        : selectedSlot == 17
                                                                            ? selectedDateTime.add(Duration(hours: 14, minutes: 30)).toString()
                                                                            : selectedSlot == 18
                                                                                ? selectedDateTime.add(Duration(hours: 15)).toString()
                                                                                : selectedSlot == 19
                                                                                    ? selectedDateTime.add(Duration(hours: 15, minutes: 30)).toString()
                                                                                    : selectedSlot == 20
                                                                                        ? selectedDateTime.add(Duration(hours: 16)).toString()
                                                                                        : selectedSlot == 21
                                                                                            ? selectedDateTime.add(Duration(hours: 16, minutes: 30)).toString()
                                                                                            : selectedSlot == 22
                                                                                                ? selectedDateTime.add(Duration(hours: 17)).toString()
                                                                                                : selectedSlot == 23
                                                                                                    ? selectedDateTime.add(Duration(hours: 17, minutes: 30)).toString()
                                                                                                    : selectedSlot == 24
                                                                                                        ? selectedDateTime.add(Duration(hours: 18)).toString()
                                                                                                        : selectedSlot == 25
                                                                                                            ? selectedDateTime.add(Duration(hours: 18, minutes: 30)).toString()
                                                                                                            : selectedSlot == 26
                                                                                                                ? selectedDateTime.add(Duration(hours: 19)).toString()
                                                                                                                : selectedSlot == 27
                                                                                                                    ? selectedDateTime.add(Duration(hours: 19, minutes: 30)).toString()
                                                                                                                    : selectedSlot == 28
                                                                                                                        ? selectedDateTime.add(Duration(hours: 20)).toString()
                                                                                                                        : selectedSlot == 29
                                                                                                                            ? selectedDateTime.add(Duration(hours: 20, minutes: 30)).toString()
                                                                                                                            : selectedSlot == 30
                                                                                                                                ? selectedDateTime.add(Duration(hours: 21)).toString()
                                                                                                                                : selectedSlot == 31
                                                                                                                                    ? selectedDateTime.add(Duration(hours: 21, minutes: 30)).toString()
                                                                                                                                    : "";
    print("bookedDateTime ------------------------- | $bookedDateTime");

    final uid = firebase_auth.FirebaseAuth.instance.currentUser.uid;
    Map<String, dynamic> bookingHistory = {
      "venueName": widget.venue.venueName,
      "pricePaid": widget.sportBookingInfo.ratesPerHr.toString(),
      "dateBooked": widget.selectedDate,
      "slotBooked": bookedDateTime,
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
          selectedDate: widget.selectedDate,
          selectedSlot: selectedSlot == 0
              ? '0600 hrs'
              : selectedSlot == 1
                  ? '0630 hrs'
                  : selectedSlot == 2
                      ? '0700 hrs'
                      : selectedSlot == 3
                          ? '0730 hrs'
                          : selectedSlot == 4
                              ? '0800 hrs'
                              : selectedSlot == 5
                                  ? '0830 hrs'
                                  : selectedSlot == 6
                                      ? '0900 hrs'
                                      : selectedSlot == 7
                                          ? '0930 hrs'
                                          : selectedSlot == 8
                                              ? '1000 hrs'
                                              : selectedSlot == 9
                                                  ? '1030 hrs'
                                                  : selectedSlot == 10
                                                      ? '1100 hrs'
                                                      : selectedSlot == 11
                                                          ? '1130 hrs'
                                                          : selectedSlot == 12
                                                              ? '1200 hrs'
                                                              : selectedSlot == 13
                                                                  ? '1230 hrs'
                                                                  : selectedSlot == 14
                                                                      ? '1300 hrs'
                                                                      : selectedSlot == 15
                                                                          ? '1330 hrs'
                                                                          : selectedSlot == 16
                                                                              ? '1400 hrs'
                                                                              : selectedSlot == 17
                                                                                  ? '1430 hrs'
                                                                                  : selectedSlot == 18
                                                                                      ? '1500 hrs'
                                                                                      : selectedSlot == 19
                                                                                          ? '1530 hrs'
                                                                                          : selectedSlot == 20
                                                                                              ? '1600 hrs'
                                                                                              : selectedSlot == 21
                                                                                                  ? '1630 hrs'
                                                                                                  : selectedSlot == 22
                                                                                                      ? '1700 hrs'
                                                                                                      : selectedSlot == 23
                                                                                                          ? '1730 hrs'
                                                                                                          : selectedSlot == 24
                                                                                                              ? '1800 hrs'
                                                                                                              : selectedSlot == 25
                                                                                                                  ? '1830 hrs'
                                                                                                                  : selectedSlot == 26
                                                                                                                      ? '1900 hrs'
                                                                                                                      : selectedSlot == 27
                                                                                                                          ? '1930 hrs'
                                                                                                                          : selectedSlot == 28
                                                                                                                              ? '2000 hrs'
                                                                                                                              : selectedSlot == 29
                                                                                                                                  ? '2030 hrs'
                                                                                                                                  : selectedSlot == 30
                                                                                                                                      ? 'at 2100 hrs'
                                                                                                                                      : selectedSlot == 31
                                                                                                                                          ? '2130 hrs'
                                                                                                                                          : "",
        ),
      ),
    );
    print({"date | ${widget.selectedDate}"});
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('booking_history');
    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
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
                'Book Slot',
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
                  //slots
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //title
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Available Slots',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),
                          //slots
                          StreamBuilder<QuerySnapshot>(
                            stream: collectionRef.snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              //loaded
                              if (snapshot.hasData && widget.selectedDate != "null" && widget.selectedDate != '') {
                                final entireBookingHistory = snapshot.data.docs.map((e) => BookingHistory.fromJson(e.data())).toList();
                                final filteredBookingHistory =
                                    entireBookingHistory.where((element) => element.dateBooked == widget.selectedDate && element.sportName == widget.sportBookingInfo.sportName && element.venueName == widget.venue.venueName).toList();

                                final slotOneBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 6)).toString()).toList();
                                final slotTwoBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 6, minutes: 30)).toString()).toList();
                                final slotThreeBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 7)).toString()).toList();
                                final slotFourBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 7, minutes: 30)).toString()).toList();
                                final slotFiveBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 8)).toString()).toList();
                                final slotSixBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 8, minutes: 30)).toString()).toList();
                                final slotSevenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 9)).toString()).toList();
                                final slotEightBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 9, minutes: 30)).toString()).toList();
                                final slotNineBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 10)).toString()).toList();
                                final slotTenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 10, minutes: 30)).toString()).toList();
                                final slotElevenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 11)).toString()).toList();
                                final slotTwelveBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 11, minutes: 30)).toString()).toList();
                                final slotThirteenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 12)).toString()).toList();
                                final slotFourteenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 12, minutes: 30)).toString()).toList();
                                final slotFifteenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 13)).toString()).toList();
                                final slotSixteenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 13, minutes: 30)).toString()).toList();
                                final slotSeventeenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 14)).toString()).toList();
                                final slotEighteenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 14, minutes: 30)).toString()).toList();
                                final slotNineteenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 15)).toString()).toList();
                                final slotTwentyBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 15, minutes: 30)).toString()).toList();
                                final slotTwentyOneBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 16)).toString()).toList();
                                final slotTwentyTwoBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 16, minutes: 30)).toString()).toList();
                                final slotTwentyThreeBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 17)).toString()).toList();
                                final slotTwentyFourBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 17, minutes: 30)).toString()).toList();
                                final slotTwentyFiveBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 18)).toString()).toList();
                                final slotTwentySixBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 18, minutes: 30)).toString()).toList();
                                final slotTwentySevenBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 19)).toString()).toList();
                                final slotTwentyEightBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 19, minutes: 30)).toString()).toList();
                                final slotTwentyNineBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 20)).toString()).toList();
                                final slotThirtyBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 20, minutes: 30)).toString()).toList();
                                final slotThirtyOneBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 21)).toString()).toList();
                                final slotThirtyTwoBooked = filteredBookingHistory.where((element) => element.slotBooked == DateTime.parse(widget.selectedDate).add(Duration(hours: 21, minutes: 30)).toString()).toList();

                                return ChipsChoice<int>.single(
                                  wrapped: true,
                                  padding: EdgeInsets.all(0),
                                  value: selectedSlot,
                                  spacing: 8.0.w,
                                  runSpacing: 10.h,
                                  onChanged: (val) {
                                    setState(() => selectedSlot = val);
                                    //ensure a date is selected
                                    if (widget.selectedDate == "null" || widget.selectedDate == '') {
                                      showCustomSnackbar('Please select a date to book', _scaffoldKey);
                                      setState(() {
                                        isCheckingAvailability = false;
                                      });
                                    }
                                  },
                                  choiceItems: C2Choice.listFrom<int, String>(
                                    source: slots,
                                    value: (index, label) => index,
                                    label: (index, label) => label,
                                    disabled: (index, label) {
                                      final thisHour = DateTime.now().hour;
                                      final time = DateTime.now().minute > 30 ? thisHour + 0.5 : thisHour;
                                      final bool timePassed = time >= compareTime[index] && DateTime.parse(widget.selectedDate).day == DateTime.now().day;

                                      if (timePassed || (label == '6 - 7 AM' && slotOneBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '6:30 -\n7:30 AM' && slotTwoBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '7 - 8 AM' && slotThreeBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '7:30 -\n8:30 AM' && slotFourBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '8 - 9 AM' && slotFiveBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '8:30 -\n9:30 AM' && slotSixBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '9 - 10 AM' && slotSevenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '9:30 -\n10:30 AM' && slotEightBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '10 - 11 AM' && slotNineBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '10:30 -\n11:30 AM' && slotTenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '11 - 12 PM' && slotElevenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '11:30 -\n12:30 PM' && slotTwelveBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '12 - 1 PM' && slotThirteenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '12:30 -\n1:30 PM' && slotFourteenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '1 - 2 PM' && slotFifteenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '1:30 -\n2:30 PM' && slotSixteenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '2 - 3 PM' && slotSeventeenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '2:30 -\n3:30 PM' && slotEighteenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '3 - 4 PM' && slotNineteenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '3:30 -\n4:30 PM' && slotTwentyBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '4 - 5 PM' && slotTwentyOneBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '4:30 -\n5:30 PM' && slotTwentyTwoBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '5 - 6 PM' && slotTwentyThreeBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '5:30 -\n6:30 PM' && slotTwentyFourBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '6 - 7 PM' && slotTwentyFiveBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '6:30 -\n7:30 PM' && slotTwentySixBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '7 - 8 PM' && slotTwentySevenBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '7:30 -\n8:30 PM' && slotTwentyEightBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '8 - 9 PM' && slotTwentyNineBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '8:30 -\n9:30 PM' && slotThirtyBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '9 - 10 PM' && slotThirtyOneBooked.isNotEmpty)) {
                                        return true;
                                      }
                                      if (timePassed || (label == '9:30 -\n10:30 PM' && slotThirtyTwoBooked.isNotEmpty)) {
                                        return true;
                                      }

                                      return false;
                                    },
                                  ),
                                  choiceBuilder: (item) {
                                    return AnimatedContainer(
                                      width: 69.h,
                                      height: 42.h,
                                      duration: Duration(milliseconds: 150),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(color: Color(0xff3E3E3E), style: BorderStyle.solid, width: 0.5.w),
                                        borderRadius: BorderRadius.circular(23.r),
                                        color: item.disabled
                                            ? Color(0xff3e3e4a)
                                            : item.selected
                                                ? Color(0xff8FD974)
                                                : Color(0xff07070A),
                                      ),
                                      child: InkWell(
                                        onTap: item.disabled
                                            ? () {}
                                            : () {
                                                item.select(!item.selected);
                                              },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Visibility(
                                              visible: item.selected,
                                              child: Text(
                                                item.label,
                                                style: TextStyle(
                                                  color: item.disabled
                                                      ? Color(0xff5f5f6e)
                                                      : item.selected
                                                          ? Colors.black
                                                          : Color(0xff707070),
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item.label,
                                              style: TextStyle(
                                                color: item.disabled
                                                    ? Color(0xff5f5f6e)
                                                    : item.selected
                                                        ? Colors.black
                                                        : Color(0xff707070),
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              //error
                              if (snapshot.hasError) {
                                return Container(
                                  height: 199.h,
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Error fetching available slots. Try again.',
                                      style: labelStyle,
                                    ),
                                  ),
                                );
                              }
                              //loading
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  height: 199.h,
                                  alignment: Alignment.center,
                                  child: SpinKitRipple(
                                    color: Color(0xff8FD974),
                                  ),
                                );
                              }
                              //default
                              return Container(
                                height: 199.h,
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Pick a date to continue',
                                    style: labelStyle,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  //details & payment
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      final sportOffered = state is FootballLoaded
                          ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Football')
                          : state is CricketLoaded
                              ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Cricket')
                              : state is BasketballLoaded
                                  ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Basketball')
                                  : state is HandballLoaded
                                      ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Handball')
                                      : state is TennisLoaded
                                          ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Tennis')
                                          : state is TableTennisLoaded
                                              ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Table Tennis')
                                              : state is SwimmingLoaded
                                                  ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Swimming')
                                                  : state is RugbyLoaded
                                                      ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Rugby')
                                                      : state is BadmintonLoaded
                                                          ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Badminton')
                                                          : state is VolleyballLoaded
                                                              ? widget.venue.sportsOffered.singleWhere((element) => element.sportName == 'Volleyball')
                                                              : null;

                      return BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, profileState) {
                          if (profileState is EditProfileLoadSuccess) {
                            final bool isMember = profileState.userProfile.verifiedClubs.contains(widget.venue.venueName);
                            return Column(
                              children: [
                                //sports and price
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                        sportOffered?.sportName == "Football"
                                            ? 'assets/icons/football_icon.png'
                                            : sportOffered?.sportName == 'Table Tennis'
                                                ? 'assets/icons/table_tennis_icon.png'
                                                : sportOffered?.sportName == "Badminton"
                                                    ? 'assets/icons/badminton_icon.png'
                                                    : sportOffered?.sportName == 'Volleyball'
                                                        ? 'assets/icons/volleyball_icon.png'
                                                        : sportOffered?.sportName == "Handball"
                                                            ? 'assets/icons/handball_icon.png'
                                                            : sportOffered?.sportName == 'Swimming'
                                                                ? 'assets/icons/swimming_icon.png'
                                                                : sportOffered?.sportName == 'Tennis'
                                                                    ? 'assets/icons/tennis_icon.png'
                                                                    : sportOffered?.sportName == 'Rugby'
                                                                        ? 'assets/icons/rugby_icon.png'
                                                                        : sportOffered?.sportName == 'Cricket'
                                                                            ? 'assets/icons/cricket_icon.png'
                                                                            : sportOffered?.sportName == "Basketball"
                                                                                ? 'assets/icons/basketball_icon.png'
                                                                                : '',
                                      ),
                                      color: Color(0xff8FD974),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      isMember
                                          ? sportOffered.memberRatesPerHr > 0
                                              ? "@ " + sportOffered.memberRatesPerHr.toString() + ' KES/hr'
                                              : "Free"
                                          : "@ " + sportOffered.ratesPerHr.toString() + ' KES/hr',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff8FD974),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "" + widget.venue.venueName,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff8FD974),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      'on ${DateFormat.MMMMEEEEd().format(DateTime.parse(widget.selectedDate))}',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff8FD974),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      selectedSlot == null
                                          ? ""
                                          : selectedSlot == 0
                                              ? 'at 0600 hrs'
                                              : selectedSlot == 1
                                                  ? 'at 0630 hrs'
                                                  : selectedSlot == 2
                                                      ? 'at 0700 hrs'
                                                      : selectedSlot == 3
                                                          ? 'at 0730 hrs'
                                                          : selectedSlot == 4
                                                              ? 'at 0800 hrs'
                                                              : selectedSlot == 5
                                                                  ? 'at 0830 hrs'
                                                                  : selectedSlot == 6
                                                                      ? 'at 0900 hrs'
                                                                      : selectedSlot == 7
                                                                          ? 'at 0930 hrs'
                                                                          : selectedSlot == 8
                                                                              ? 'at 1000 hrs'
                                                                              : selectedSlot == 9
                                                                                  ? 'at 1030 hrs'
                                                                                  : selectedSlot == 10
                                                                                      ? 'at 1100 hrs'
                                                                                      : selectedSlot == 11
                                                                                          ? 'at 1130 hrs'
                                                                                          : selectedSlot == 12
                                                                                              ? 'at 1200 hrs'
                                                                                              : selectedSlot == 13
                                                                                                  ? 'at 1230 hrs'
                                                                                                  : selectedSlot == 14
                                                                                                      ? 'at 1300 hrs'
                                                                                                      : selectedSlot == 15
                                                                                                          ? 'at 1330 hrs'
                                                                                                          : selectedSlot == 16
                                                                                                              ? 'at 1400 hrs'
                                                                                                              : selectedSlot == 17
                                                                                                                  ? 'at 1430 hrs'
                                                                                                                  : selectedSlot == 18
                                                                                                                      ? 'at 1500 hrs'
                                                                                                                      : selectedSlot == 19
                                                                                                                          ? 'at 1530 hrs'
                                                                                                                          : selectedSlot == 20
                                                                                                                              ? 'at 1600 hrs'
                                                                                                                              : selectedSlot == 21
                                                                                                                                  ? 'at 1630 hrs'
                                                                                                                                  : selectedSlot == 22
                                                                                                                                      ? 'at 1700 hrs'
                                                                                                                                      : selectedSlot == 23
                                                                                                                                          ? 'at 1730 hrs'
                                                                                                                                          : selectedSlot == 24
                                                                                                                                              ? 'at 1800 hrs'
                                                                                                                                              : selectedSlot == 25
                                                                                                                                                  ? 'at 1830 hrs'
                                                                                                                                                  : selectedSlot == 26
                                                                                                                                                      ? 'at 1900 hrs'
                                                                                                                                                      : selectedSlot == 27
                                                                                                                                                          ? 'at 1930 hrs'
                                                                                                                                                          : selectedSlot == 28
                                                                                                                                                              ? 'at 2000 hrs'
                                                                                                                                                              : selectedSlot == 29
                                                                                                                                                                  ? 'at 2030 hrs'
                                                                                                                                                                  : selectedSlot == 30
                                                                                                                                                                      ? 'at 2100 hrs'
                                                                                                                                                                      : selectedSlot == 31
                                                                                                                                                                          ? 'at 2130 hrs'
                                                                                                                                                                          : "",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff8FD974),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                //lipa na mpesa
                                isMember && sportOffered.memberRatesPerHr == 0
                                    ? Container()
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 32.w, right: 32.w),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Enter M-PESA Number',
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),

                                          //txtbox
                                          Padding(
                                            padding: EdgeInsets.only(left: 32.w, right: 32.w),
                                            child: Container(
                                              child: Padding(
                                                padding: MediaQuery.of(context).viewInsets,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.number,
                                                  enabled: isBooked ? false : true,
                                                  controller: phoneNumber,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: '7XXXXXXXX',
                                                    alignLabelWithHint: true,
                                                    isDense: true,
                                                    enabled: true,
                                                    fillColor: Color(0xff31323B),
                                                    filled: true,
                                                    hintStyle: labelStyle,
                                                    labelStyle: labelStyle,
                                                    prefixIcon: Container(
                                                      width: 24.w,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff31323B),
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(8.r),
                                                          topLeft: Radius.circular(8.r),
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(bottom: 2.h),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        '+254',
                                                        style: labelStyle.copyWith(
                                                          color: Color(0xff9BEB81),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        style: BorderStyle.none,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8.r),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        style: BorderStyle.none,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8.r),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        style: BorderStyle.none,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8.r),
                                                    ),
                                                    disabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        style: BorderStyle.none,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8.r),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                //pay btn
                                isMember && sportOffered.memberRatesPerHr == 0 ? SizedBox.shrink() : SizedBox(height: 48.h),

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
                                  child: isCheckingAvailability == false
                                      ? isMember == true && sportOffered.memberRatesPerHr == 0
                                          ? Text(
                                              'Book',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.sp,
                                              ),
                                            )
                                          : Text(
                                              'Pay',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.sp,
                                              ),
                                            )
                                      : Container(
                                          width: 24.h,
                                          height: 24.h,
                                          child: SpinKitRipple(
                                            color: Colors.black,
                                          ),
                                        ),
                                  onPressed: () async {
                                    //unfocus field
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    //set loading
                                    setState(() {
                                      isCheckingAvailability = true;
                                    });

                                    //push stk
                                    await startTransaction(amount: 1, phone: "254" + phoneNumber.text);

                                    if (selectedSlot != null && isMember == true && sportOffered.memberRatesPerHr == 0) {
                                      updateBookingHistory();
                                    } else if (selectedSlot != null && phoneNumber.text.length == 9 && phoneNumber.text.startsWith('7')) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (BuildContext context) {
                                          return PaymentScreen(
                                            selectedDate: widget.selectedDate,
                                            venue: widget.venue,
                                            selectedSlot: selectedSlot,
                                            sportBookingInfo: widget.sportBookingInfo,
                                            checkoutId: checkoutId,
                                          );
                                        }),
                                      );
                                      setState(() {
                                        isCheckingAvailability = false;
                                      });
                                    } else {
                                      showCustomSnackbar('Error booking slot. Please input all the fields correctly', _scaffoldKey);
                                      setState(() {
                                        isCheckingAvailability = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: 20.h),
                              ],
                            );
                          }
                          return Container();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
