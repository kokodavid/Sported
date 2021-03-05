import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/presentation/shared/filter_chips/select_sport.dart';
import 'package:sported_app/presentation/widgets/bookings/bookings_grid.dart';

class BookingsHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //app bar
        SliverAppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          title: Text(
            'Bookings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              //select sports
              SelectSport(),

              //bookings
              BookingsGrid(),
            ],
          ),
        ),
      ],
    );
  }
}
