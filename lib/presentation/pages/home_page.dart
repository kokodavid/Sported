import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sported_app/presentation/widgets/home/g_map.dart';
import 'package:sported_app/presentation/widgets/home/home_carousel.dart';
import 'package:sported_app/presentation/widgets/home/home_page_sports_filter.dart';
import 'package:sported_app/presentation/widgets/home/home_top_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Widget> buildHeavyWidget() async {
    return GMap();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //GMap
        FutureBuilder(
          future: buildHeavyWidget(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return snapshot.data;
            }
            return Container(
              height: 1.sh,
              width: 1.sw,
              color: Colors.black,
              child: SpinKitRipple(
                color: Color(0xff8FD974),
              ),
            );
          },
        ),

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
