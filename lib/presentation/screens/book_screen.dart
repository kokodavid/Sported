import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/data/models/booking/booking_history_model.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';
import 'package:sported_app/data/repositories/booking_history_data_provider.dart';
import 'package:sported_app/presentation/screens/payment_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookScreen extends StatefulWidget {
  final sportBookingInfo;
  final List<BookingHistory> entireBookingHistory;
  final Venue venue;
  final BookingHistoryDataProvider bookingHistoryDataProvider;
  const BookScreen({
    Key key,
    this.entireBookingHistory,
    @required this.venue,
    @required this.sportBookingInfo,
    this.bookingHistoryDataProvider,
  }) : super(key: key);
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  String selectedDate;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedSlot = 0;
  bool isCheckingAvailability = false;
  String convertedSlot;

  @override
  void initState() {
    selectedDate = '';
    super.initState();
  }

  List<String> slots = [
    '0600 hrs',
    '0700 hrs',
    '0800 hrs',
    '0900 hrs',
    '1000 hrs',
    '1100 hrs',
    '1200 hrs',
    '1300 hrs',
    '1400 hrs',
    '1500 hrs',
    '1600 hrs',
    '1700 hrs',
    '1800 hrs',
    '1900 hrs',
    '2000 hrs',
    '2100 hrs',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (overscroll) {
          overscroll.disallowGlow();
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
              'Book',
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
                SizedBox(height: 20.h),

                //calendar
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
                        selectedDate = args.value.toString();
                      });

                      print("calendar selected date | $selectedDate");
                    },
                  ),
                ),

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
                            'Pick Slot',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        //slots
                        ChipsChoice<int>.single(
                          wrapped: true,
                          padding: EdgeInsets.all(0),
                          value: selectedSlot,
                          spacing: 8.0.w,
                          runSpacing: 10.h,
                          onChanged: (val) {
                            setState(() => selectedSlot = val);
                          },
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: slots,
                            value: (int, string) => int,
                            label: (int, string) => string,
                          ),
                          choiceBuilder: (item) {
                            return Column(
                              children: [
                                AnimatedContainer(
                                  width: 69.h,
                                  height: 42.h,
                                  duration: Duration(milliseconds: 150),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Color(0xff3E3E3E), style: BorderStyle.solid, width: 0.5.w),
                                    borderRadius: BorderRadius.circular(23.r),
                                    color: item.selected ? Color(0xff8FD974) : Color(0xff07070A),
                                  ),
                                  child: InkWell(
                                    onTap: () {
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
                                              color: item.selected ? Colors.black : Color(0xff707070),
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          item.label,
                                          style: TextStyle(
                                            color: item.selected ? Colors.black : Color(0xff707070),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 64.h),

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
                  child: isCheckingAvailability == false
                      ? Text(
                          'Pay',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        )
                      : Container(
                          // width: 25.w,
                          // child: SpinKitRipple(
                          //   color: Colors.black,
                          // ),
                        ),
                  onPressed: () async {
                    setState(() {
                      isCheckingAvailability = true;
                    });

                    //ensure a date is selected
                    if (selectedDate == "null" || selectedDate == '') {
                      _showErrorSnackbar('Please select a date to book');
                      setState(() {
                        isCheckingAvailability = false;
                      });
                    } else {
                      bookingValidation();
                    }
                  },
                ),

                SizedBox(height: 20.h),
              ],
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

  bookingValidation() async {
    print("selected date | $selectedDate");
    print("selected slot | $selectedSlot");

    //get entire booking history
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final entireBookingHistory = await firestore.collection('booking_history').get().then((value) => value.docs.map((e) => BookingHistory.fromJson(e.data())).toList());
    print("entire | ${entireBookingHistory.length}");

    //return list of all bookings of this venue, of this sport, at this selected date
    final List<BookingHistory> filteredBookingHistory = entireBookingHistory
        .where(
          (element) => element.dateBooked == selectedDate && element.sportName == widget.sportBookingInfo.sportName && element.venueName == widget.venue.venueName,
        )
        .toList();

    print("filtered | ${filteredBookingHistory.length}");

    //list where slot has been booked
    final slotOneBooked = filteredBookingHistory.where((element) => element.slotBooked == "0600 hrs").toList();
    final slotTwoBooked = filteredBookingHistory.where((element) => element.slotBooked == "0700 hrs").toList();
    final slotThreeBooked = filteredBookingHistory.where((element) => element.slotBooked == "0800 hrs").toList();
    final slotFourBooked = filteredBookingHistory.where((element) => element.slotBooked == "0900 hrs").toList();
    final slotFiveBooked = filteredBookingHistory.where((element) => element.slotBooked == "1000 hrs").toList();
    final slotSixBooked = filteredBookingHistory.where((element) => element.slotBooked == "1100 hrs").toList();
    final slotSevenBooked = filteredBookingHistory.where((element) => element.slotBooked == "1200 hrs").toList();
    final slotEightBooked = filteredBookingHistory.where((element) => element.slotBooked == "1300 hrs").toList();
    final slotNineBooked = filteredBookingHistory.where((element) => element.slotBooked == "1400 hrs").toList();
    final slotTenBooked = filteredBookingHistory.where((element) => element.slotBooked == "1500 hrs").toList();
    final slotElevenBooked = filteredBookingHistory.where((element) => element.slotBooked == "1600 hrs").toList();
    final slotTwelveBooked = filteredBookingHistory.where((element) => element.slotBooked == "1700 hrs").toList();
    final slotThirteenBooked = filteredBookingHistory.where((element) => element.slotBooked == "1800 hrs").toList();
    final slotFourteenBooked = filteredBookingHistory.where((element) => element.slotBooked == "1900 hrs").toList();
    final slotFifteenBooked = filteredBookingHistory.where((element) => element.slotBooked == "2000 hrs").toList();
    final slotSixteenBooked = filteredBookingHistory.where((element) => element.slotBooked == "2100 hrs").toList();

    //navigate or show snackbar
    if (selectedSlot == 0) {
      if (slotOneBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 1) {
      if (slotTwoBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 2) {
      if (slotThreeBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 3) {
      if (slotFourBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 4) {
      if (slotFiveBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 5) {
      if (slotSixBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 6) {
      if (slotSevenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 7) {
      if (slotEightBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 8) {
      if (slotNineBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 9) {
      if (slotTenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 10) {
      if (slotElevenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 11) {
      if (slotTwelveBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 12) {
      if (slotThirteenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 13) {
      if (slotFourteenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 14) {
      if (slotFifteenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    if (selectedSlot == 15) {
      if (slotSixteenBooked.isEmpty) {
        print("isEmpty | bookable");
        //navigate
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PaymentScreen(
              selectedDate: selectedDate,
              venue: widget.venue,
              selectedSlot: selectedSlot,
              sportBookingInfo: widget.sportBookingInfo,
            );
          }),
        );
      } else {
        print("isNotEmpty | not bookable");
        //show snackbar
        _showErrorSnackbar('Slot is booked');
      }
    }

    setState(() {
      isCheckingAvailability = false;
    });
  }
}
