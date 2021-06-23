import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:sported_app/presentation/shared/custom_snackbar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'book_slot_screen.dart';

class BookDateScreen extends StatefulWidget {
  final sportBookingInfo;
  final List<BookingHistory> entireBookingHistory;
  final Venue venue;
  final BookingHistoryDataProvider bookingHistoryDataProvider;

  const BookDateScreen({
    Key key,
    this.entireBookingHistory,
    @required this.venue,
    @required this.sportBookingInfo,
    this.bookingHistoryDataProvider,
  }) : super(key: key);

  @override
  _BookDateScreenState createState() => _BookDateScreenState();
}

class _BookDateScreenState extends State<BookDateScreen> {
  TextEditingController phoneNumber = TextEditingController();
  String selectedDate;
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

  @override
  void initState() {
    selectedDate = '';
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

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
                'Select Date',
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
                  //calendar
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 32.w, right: 32.w),
                    child: SfDateRangePicker(
                      //styles
                      headerStyle: DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: regularStyle,
                        blackoutDateTextStyle: TextStyle(
                          color: Color(0x80bbbbbc),
                          fontSize: 15.sp,
                        ),
                        todayTextStyle: TextStyle(
                          color: Color(0xff8FD974),
                          fontSize: 15.sp,
                        ),
                        disabledDatesTextStyle: TextStyle(
                          color: Color(0x80bbbbbc),
                          fontSize: 15.sp,
                        ),
                      ),
                      yearCellStyle: DateRangePickerYearCellStyle(
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        todayTextStyle: TextStyle(
                          color: Color(0xff8FD974),
                          fontSize: 15.sp,
                        ),
                        disabledDatesTextStyle: TextStyle(
                          color: Color(0x80bbbbbc),
                          fontSize: 15.sp,
                        ),
                      ),
                      selectionTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),

                      //settings
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        dayFormat: 'EEE',
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: regularStyle,
                        ),
                        firstDayOfWeek: DateTime.monday,
                        weekendDays: [
                          DateTime.saturday,
                          DateTime.sunday,
                        ],
                      ),

                      //colors
                      selectionColor: Color(0xff8FD974),
                      todayHighlightColor: Color(0xff8FD974),

                      //logic
                      enablePastDates: false,
                      toggleDaySelection: true,
                      showNavigationArrow: true,
                      selectionMode: DateRangePickerSelectionMode.single,

                      //onTap
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
                        setState(() {
                          selectedSlot = null;
                          selectedDate = args.value.toString();
                        });

                        print("calendar selected date | $selectedDate");
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),

                  //details & payment
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      final sportOffered = state is FootballLoaded
                          ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Football')
                          : state is CricketLoaded
                              ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Cricket')
                              : state is BasketballLoaded
                                  ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Basketball')
                                  : state is HandballLoaded
                                      ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Handball')
                                      : state is TennisLoaded
                                          ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Tennis')
                                          : state is TableTennisLoaded
                                              ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Table Tennis')
                                              : state is SwimmingLoaded
                                                  ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Swimming')
                                                  : state is RugbyLoaded
                                                      ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Rugby')
                                                      : state is BadmintonLoaded
                                                          ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Badminton')
                                                          : state is VolleyballLoaded
                                                              ? widget.venue.sportsOffered?.singleWhere((element) => element.sportName == 'Volleyball')
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
                                        sportOffered.sportName == "Football"
                                            ? 'assets/icons/football_icon.png'
                                            : sportOffered.sportName == 'Table Tennis'
                                                ? 'assets/icons/table_tennis_icon.png'
                                                : sportOffered.sportName == "Badminton"
                                                    ? 'assets/icons/badminton_icon.png'
                                                    : sportOffered.sportName == 'Volleyball'
                                                        ? 'assets/icons/volleyball_icon.png'
                                                        : sportOffered.sportName == "Handball"
                                                            ? 'assets/icons/handball_icon.png'
                                                            : sportOffered.sportName == 'Swimming'
                                                                ? 'assets/icons/swimming_icon.png'
                                                                : sportOffered.sportName == 'Tennis'
                                                                    ? 'assets/icons/tennis_icon.png'
                                                                    : sportOffered.sportName == 'Rugby'
                                                                        ? 'assets/icons/rugby_icon.png'
                                                                        : sportOffered.sportName == 'Cricket'
                                                                            ? 'assets/icons/cricket_icon.png'
                                                                            : sportOffered.sportName == "Basketball"
                                                                                ? 'assets/icons/basketball_icon.png'
                                                                                : '',
                                      ),
                                      color: Color(0xff8FD974),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      isMember
                                          ? sportOffered.memberRatesPerHr != 0
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
                                      "at " + widget.venue.venueName,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff8FD974),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      selectedDate != "null" && selectedDate != '' ? 'on ${DateFormat.MMMMEEEEd().format(DateTime.parse(selectedDate))}' : "",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Color(0xff8FD974),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 30.h),

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
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  onPressed: () async {
                                    //unfocus field
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    //go to slots screen
                                    if (selectedDate.isNotEmpty && selectedDate != "null" && selectedDate != '') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => BookSlotScreen(
                                            sportBookingInfo: widget.sportBookingInfo,
                                            selectedDate: selectedDate,
                                            venue: widget.venue,
                                          ),
                                        ),
                                      );
                                    } else {
                                      showCustomSnackbar('Please pick a date to continue!', _scaffoldKey);
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

                  // MaterialButton(
                  //   color: Colors.red,
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (BuildContext context) => BookSlotScreen(
                  //           sportBookingInfo: widget.sportBookingInfo,
                  //           selectedDate: selectedDate,
                  //           venue: widget.venue,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
