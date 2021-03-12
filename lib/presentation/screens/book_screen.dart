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
                        slots = [
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
                      });

                      //get entire booking history
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      final entireBookingHistory = await firestore
                          .collection('booking_history')
                          .get()
                          .then((value) =>
                              value.docs.map((e) => BookingHistory.fromJson(e.data())).toList());

                      //return list of all bookings of this venue, of this sport, at this selected date
                      final List<BookingHistory> filteredBookingHistory = entireBookingHistory
                          .where(
                            (element) =>
                                element.dateBooked == selectedDate &&
                                element.sportName == widget.sportBookingInfo.sportName &&
                                element.venueName == widget.venue.venueName,
                          )
                          .toList();

                      filteredBookingHistory.forEach((element) {
                        element.slotBooked == '0600 hrs'
                            ? setState(() {
                                slots = [
                                  'Booked',
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
                              })
                            : element.slotBooked == '0700 hrs'
                                ? setState(() {
                                    slots = [
                                      '0600 hrs',
                                      'Booked',
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
                                  })
                                : element.slotBooked == '0800 hrs'
                                    ? setState(() {
                                        slots = [
                                          '0600 hrs',
                                          '0700 hrs',
                                          'Booked',
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
                                      })
                                    : element.slotBooked == '0900 hrs'
                                        ? setState(() {
                                            slots = [
                                              '0600 hrs',
                                              '0700 hrs',
                                              '0800 hrs',
                                              'Booked',
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
                                          })
                                        : element.slotBooked == '1000 hrs'
                                            ? setState(() {
                                                slots = [
                                                  '0600 hrs',
                                                  '0700 hrs',
                                                  '0800 hrs',
                                                  '0900 hrs',
                                                  'Booked',
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
                                              })
                                            : element.slotBooked == '1100 hrs'
                                                ? setState(() {
                                                    slots = [
                                                      '0600 hrs',
                                                      '0700 hrs',
                                                      '0800 hrs',
                                                      '0900 hrs',
                                                      '1000 hrs',
                                                      'Booked',
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
                                                  })
                                                : element.slotBooked == '1200 hrs'
                                                    ? setState(() {
                                                        slots = [
                                                          '0600 hrs',
                                                          '0700 hrs',
                                                          '0800 hrs',
                                                          '0900 hrs',
                                                          '1000 hrs',
                                                          '1100 hrs',
                                                          'Booked',
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
                                                      })
                                                    : element.slotBooked == '1300 hrs'
                                                        ? setState(() {
                                                            slots = [
                                                              '0600 hrs',
                                                              '0700 hrs',
                                                              '0800 hrs',
                                                              '0900 hrs',
                                                              '1000 hrs',
                                                              '1100 hrs',
                                                              '1200 hrs',
                                                              'Booked',
                                                              '1400 hrs',
                                                              '1500 hrs',
                                                              '1600 hrs',
                                                              '1700 hrs',
                                                              '1800 hrs',
                                                              '1900 hrs',
                                                              '2000 hrs',
                                                              '2100 hrs',
                                                            ];
                                                          })
                                                        : element.slotBooked == '1400 hrs'
                                                            ? setState(() {
                                                                slots = [
                                                                  '0600 hrs',
                                                                  '0700 hrs',
                                                                  '0800 hrs',
                                                                  '0900 hrs',
                                                                  '1000 hrs',
                                                                  '1100 hrs',
                                                                  '1200 hrs',
                                                                  '1300 hrs',
                                                                  'Booked',
                                                                  '1500 hrs',
                                                                  '1600 hrs',
                                                                  '1700 hrs',
                                                                  '1800 hrs',
                                                                  '1900 hrs',
                                                                  '2000 hrs',
                                                                  '2100 hrs',
                                                                ];
                                                              })
                                                            : element.slotBooked == '1500 hrs'
                                                                ? setState(() {
                                                                    slots = [
                                                                      '0600 hrs',
                                                                      '0700 hrs',
                                                                      '0800 hrs',
                                                                      '0900 hrs',
                                                                      '1000 hrs',
                                                                      '1100 hrs',
                                                                      '1200 hrs',
                                                                      'Booked',
                                                                      '1400 hrs',
                                                                      '1500 hrs',
                                                                      '1600 hrs',
                                                                      '1700 hrs',
                                                                      '1800 hrs',
                                                                      '1900 hrs',
                                                                      '2000 hrs',
                                                                      '2100 hrs',
                                                                    ];
                                                                  })
                                                                : element.slotBooked == '1600 hrs'
                                                                    ? setState(() {
                                                                        slots = [
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
                                                                          'Booked',
                                                                          '1700 hrs',
                                                                          '1800 hrs',
                                                                          '1900 hrs',
                                                                          '2000 hrs',
                                                                          '2100 hrs',
                                                                        ];
                                                                      })
                                                                    : element.slotBooked ==
                                                                            '1700 hrs'
                                                                        ? setState(() {
                                                                            slots = [
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
                                                                              'Booked',
                                                                              '1800 hrs',
                                                                              '1900 hrs',
                                                                              '2000 hrs',
                                                                              '2100 hrs',
                                                                            ];
                                                                          })
                                                                        : element.slotBooked ==
                                                                                '1800 hrs'
                                                                            ? setState(() {
                                                                                slots = [
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
                                                                                  'Booked',
                                                                                  '1900 hrs',
                                                                                  '2000 hrs',
                                                                                  '2100 hrs',
                                                                                ];
                                                                              })
                                                                            : element.slotBooked ==
                                                                                    '1900 hrs'
                                                                                ? setState(() {
                                                                                    slots = [
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
                                                                                      'Booked',
                                                                                      '2000 hrs',
                                                                                      '2100 hrs',
                                                                                    ];
                                                                                  })
                                                                                : element.slotBooked ==
                                                                                        '2000 hrs'
                                                                                    ? setState(() {
                                                                                        slots = [
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
                                                                                          'Booked',
                                                                                          '2100 hrs',
                                                                                        ];
                                                                                      })
                                                                                    : element.slotBooked ==
                                                                                            '2100 hrs'
                                                                                        ? setState(
                                                                                            () {
                                                                                            slots =
                                                                                                [
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
                                                                                              'Booked',
                                                                                            ];
                                                                                          })
                                                                                        : Container();
                      });

                      print('slots | $slots');
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
                            'Slots Available',
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
                                    border: Border.all(
                                        color: Color(0xff3E3E3E),
                                        style: BorderStyle.solid,
                                        width: 0.5.w),
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
                                              color:
                                                  item.selected ? Colors.black : Color(0xff707070),
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
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  onPressed: () {
                    /*
                    if ((widget.sportBookingInfo[selectedSlot]['date'].toString() != '') &&
                        widget.sportBookingInfo[selectedSlot]['isBooked'] == false) {

                    }
                     */

                    /*
                    if selectedslot is 3 & isBooked is false allow navigation to next screen & if payment is successfull set isBooked boolean of slot '0900' to true
                    if selectedslot is 3 & isBooked is true disable navigation to next screen until user selects available slot; show snackbar
                    */

                    /*
                    if payment is successfull
                    add sportName; venueName; slotBooked; dateBooked to booking history collection
                    */

                    //update firestore with selected slot

                    selectedDate.isEmpty
                        ? _showErrorSnackbar('Please select a date to book')
                        : slots[selectedSlot] == 'Booked'
                            ? _showErrorSnackbar('This slot is already booked, as indicated')
                            : Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return PaymentScreen(
                                    selectedDate: selectedDate,
                                    venue: widget.venue,
                                    selectedSlot: selectedSlot,
                                    sportBookingInfo: widget.sportBookingInfo,
                                  );
                                }),
                              );
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
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
