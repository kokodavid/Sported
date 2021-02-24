import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/business_logic/blocs/nav_bloc/nav_bloc.dart';
import 'package:sported_app/pages/bookings_page.dart';
import 'package:sported_app/pages/buddies_page.dart';
import 'package:sported_app/pages/events_page.dart';
import 'package:sported_app/pages/home_page.dart';
import 'package:sported_app/pages/profile_page.dart';
import 'package:sported_app/screens/venues_screen.dart';

class PagesSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: state is LoadedPageOne
                ? ProfilePage()
                : state is LoadedPageTwo
                    ? BookingsHistoryPage()
                    : state is LoadedPageThree
                        ? HomePage()
                        : state is LoadedPageFour
                            ? EventsPage()
                            : state is LoadedPageFive
                                ? BuddiesPage()
                                : state is LoadedVenuesPage
                                    ? VenuesScreen()
                                    : null,
            bottomNavigationBar: StyleProvider(
              style: Style(),
              child: ConvexAppBar(
                items: [
                  TabItem(
                    icon: Icon(Icons.person, size: 28.r),
                    activeIcon: Icon(Icons.person, size: 32.r),
                  ),
                  TabItem(
                    icon: Icon(Icons.event, size: 28.r),
                    activeIcon: Icon(Icons.event, size: 32.r),
                  ),
                  TabItem(
                    icon: Icon(Icons.location_on_sharp, size: 28.r),
                    activeIcon: Icon(Icons.location_on_sharp, size: 32.r),
                  ),
                  TabItem(
                    icon: Icon(Icons.event_note, size: 28.r),
                    activeIcon: Icon(Icons.event_note, size: 32.r),
                  ),
                  TabItem(
                    icon: Icon(MdiIcons.humanQueue, size: 28.r),
                    activeIcon: Icon(MdiIcons.humanQueue, size: 32.w),
                  ),
                ],
                curveSize: 50.r,
                height: 60.h,
                top: -10.h,
                activeColor: Color(0xff8FD974),
                backgroundColor: Color(0xff8FD974),
                elevation: 0.0,
                style: TabStyle.reactCircle,
                initialActiveIndex: 2,
                onTap: (int i) {
                  if (i == 0) {
                    return BlocProvider.of<NavBloc>(context).add(LoadPageOne());
                  }
                  if (i == 1) {
                    return BlocProvider.of<NavBloc>(context).add(LoadPageTwo());
                  }
                  if (i == 2) {
                    return BlocProvider.of<NavBloc>(context).add(LoadPageThree());
                  }
                  if (i == 3) {
                    return BlocProvider.of<NavBloc>(context).add(LoadPageFour());
                  }
                  if (i == 4) {
                    return BlocProvider.of<NavBloc>(context).add(LoadPageFive());
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 28.r;

  @override
  double get activeIconMargin => 20.h;

  @override
  double get iconSize => 28.r;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 20, color: Colors.black);
  }
}
