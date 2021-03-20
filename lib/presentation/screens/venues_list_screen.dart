import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/business_logic/blocs/filter_bloc/filter_bloc.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';
import 'package:sported_app/presentation/widgets/venues_list/filtered_venues.dart';
import 'package:sported_app/presentation/widgets/venues_list/venues_list_sports_filter.dart';

class VenuesListScreen extends StatefulWidget {
  final Venue venueModel;
  const VenuesListScreen({Key key, this.venueModel}) : super(key: key);

  @override
  _VenuesListScreenState createState() => _VenuesListScreenState();
}

class _VenuesListScreenState extends State<VenuesListScreen> {
  // Map<String, dynamic> data = {
  //   "venueName": "Impala Club",
  //   "timeOpen": "0600",
  //   "timeClosed": "2100",
  //   "totalDaysOpen": 2,
  //   "sportsOfferedList": ["Football", "Badminton", "Cricket", "Basketball", "Swimming"],
  //   "sportsOffered": [
  //     {
  //       "sportName": "Football",
  //       "ratesPerHr": 3800,
  //       "slots": [
  //         {"date": "", "time": "0900", "isBooked": false},
  //         {"date": "", "time": "1000", "isBooked": false},
  //         {"date": "", "time": "1100", "isBooked": false},
  //         {"date": "", "time": "1200", "isBooked": false},
  //       ]
  //     },
  //     {
  //       "sportName": "Badminton",
  //       "ratesPerHr": 1400,
  //       "slots": [
  //         {"date": "", "time": "0900", "isBooked": false},
  //         {"date": "", "time": "1000", "isBooked": false},
  //         {"date": "", "time": "1100", "isBooked": false},
  //         {"date": "", "time": "1200", "isBooked": false},
  //       ]
  //     },
  //     {
  //       "sportName": "Cricket",
  //       "ratesPerHr": 900,
  //       "slots": [
  //         {"date": "", "time": "0900", "isBooked": false},
  //         {"date": "", "time": "1000", "isBooked": false},
  //         {"date": "", "time": "1100", "isBooked": false},
  //         {"date": "", "time": "1200", "isBooked": false},
  //       ]
  //     },
  //     {
  //       "sportName": "Basketball",
  //       "ratesPerHr": 3400,
  //       "slots": [
  //         {"date": "", "time": "0900", "isBooked": false},
  //         {"date": "", "time": "1000", "isBooked": false},
  //         {"date": "", "time": "1100", "isBooked": false},
  //         {"date": "", "time": "1200", "isBooked": false},
  //       ]
  //     },
  //     {
  //       "sportName": "Swimming",
  //       "ratesPerHr": 2000,
  //       "slots": [
  //         {"date": "", "time": "0900", "isBooked": false},
  //         {"date": "", "time": "1000", "isBooked": false},
  //         {"date": "", "time": "1100", "isBooked": false},
  //         {"date": "", "time": "1200", "isBooked": false},
  //       ]
  //     },
  //   ]
  // };
  //
  // addVenue() {
  //   final ref = FirebaseFirestore.instance.collection('venues');
  //   ref.add(data);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            title: Text(
              'Venues',
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
                //select sports
                VenuesListSportsFilter(),

                //title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 32.w, bottom: 20.h, top: 10.h),
                    child: Text(
                      'Venues',
                      style: regularStyle,
                    ),
                  ),
                ),
                //
                // // list of venues
                BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    if (state is FootballLoaded) {
                      final footballVenues = state.footballVenues;
                      return FilteredVenues(
                          filteredVenues: footballVenues, sportToBook: 'Football');
                    }
                    if (state is CricketLoaded) {
                      final cricketVenues = state.cricketVenues;

                      return FilteredVenues(filteredVenues: cricketVenues, sportToBook: 'Cricket');
                    }
                    if (state is BadmintonLoaded) {
                      final badmintonVenues = state.badmintonVenues;
                      return FilteredVenues(
                          filteredVenues: badmintonVenues, sportToBook: 'Badminton');
                    }
                    if (state is BasketballLoaded) {
                      final basketballVenues = state.basketballVenues;

                      return FilteredVenues(
                          filteredVenues: basketballVenues, sportToBook: 'Basketball');
                    }
                    if (state is TennisLoaded) {
                      final tennisVenues = state.tennisVenues;
                      return FilteredVenues(filteredVenues: tennisVenues, sportToBook: 'Tennis');
                    }

                    if (state is SwimmingLoaded) {
                      final swimmingVenues = state.swimmingVenues;
                      return FilteredVenues(
                          filteredVenues: swimmingVenues, sportToBook: 'Swimming');
                    }
                    if (state is VolleyballLoaded) {
                      final volleyballVenues = state.volleyballVenues;
                      return FilteredVenues(
                          filteredVenues: volleyballVenues, sportToBook: 'Volleyball');
                    }
                    if (state is RugbyLoaded) {
                      final rugbyVenues = state.rugbyVenues;
                      return FilteredVenues(filteredVenues: rugbyVenues, sportToBook: 'Rugby');
                    }
                    if (state is TableTennisLoaded) {
                      final tableTennisVenues = state.tableTennisVenues;
                      return FilteredVenues(
                          filteredVenues: tableTennisVenues, sportToBook: 'Table Tennis');
                    }
                    if (state is HandballLoaded) {
                      final handballVenues = state.handballVenues;
                      return FilteredVenues(
                          filteredVenues: handballVenues, sportToBook: 'Handball');
                    }
                    return Container(
                      height: 200.h,
                      child: Center(
                        // child: SpinKitRipple(
                        //   color: Color(0xff9BEB81),
                        // ),
                      ),
                    );

                  },
                ),

                // FilteredVenues(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
