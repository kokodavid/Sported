import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/presentation/widgets/home/g_map.dart';
import 'package:sported_app/presentation/widgets/home/home_carousel.dart';
import 'package:sported_app/presentation/widgets/home/home_page_sports_filter.dart';
import 'package:sported_app/presentation/widgets/home/home_top_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //map
        GMap(),

        //search
        HomeTopBar(),

        //select sport
        Positioned(top: 48.0.h, right: 0.0, left: 0.0, child: HomePageSportsFilter()),

        //carousel
        HomeCarousel(),
      ],
    );
  }
}
