import 'package:flutter/material.dart';
import 'package:sported_app/widgets/home/g_map.dart';
import 'package:sported_app/widgets/home/home_carousel.dart';
import 'package:sported_app/widgets/home/home_top_bar.dart';

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

        /*
        //select sport
        // Positioned(
        //   top: 20.h,
        //   child: Container(
        //     height: 40,
        //     width: 40,
        //     color: Colors.blue,
        //   ),
        // ),
        */

        //carousel
        HomeCarousel(),
      ],
    );
  }
}
