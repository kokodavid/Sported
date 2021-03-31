import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/business_logic/blocs/auth/authentication_bloc.dart';
import 'package:sported_app/business_logic/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/data/repositories/auth_repo.dart';
import 'package:sported_app/data/services/authentication_service.dart';
import 'package:sported_app/presentation/screens/edit_profile_screen.dart';
import 'package:sported_app/presentation/shared/authenticate.dart';

class ProfilePage extends StatefulWidget {
  final scaffoldKey;

  const ProfilePage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String newAviUrl;
  bool isLoggingOut = false;

  final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // getUserProfile();
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xffd0e9c8),
        duration: Duration(milliseconds: 2000),
        content: Text(
          "$message",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime joinedSportedRaw = firebase_auth.FirebaseAuth.instance.currentUser.metadata.creationTime;
    final joinedSported = DateFormat.yMMMd().format(joinedSportedRaw);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              //avi
              currentUser.photoURL != null
                  ? Container(
                      width: 1.sw,
                      height: 464.h,
                      child: Image.network(
                        currentUser.photoURL,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    )
                  : Container(
                      width: 1.sw,
                      height: 464.h,
                      padding: EdgeInsets.only(bottom: 140.h),
                      child: Icon(
                        Icons.person_rounded,
                        color: Color(0xff31323B),
                        size: 155.0.r,
                      ),
                    ),

              // name
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(
                    height: 48.h,
                    width: 1.sw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Colors.black12,
                      boxShadow: [
                        BoxShadow(color: Color(0x66000000), blurRadius: 10.r, spreadRadius: 10.r),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.0.h),
                      child: currentUser.displayName != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentUser.displayName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(width: 4.0.w),
                                //edit name
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  constraints: BoxConstraints(
                                    maxHeight: 20.h,
                                    minHeight: 20.h,
                                    minWidth: 20.w,
                                    maxWidth: 20.w,
                                  ),
                                  icon: Icon(
                                    MdiIcons.clipboardEdit,
                                    color: Colors.white,
                                    size: 20.r,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<EditProfileCubit>(
                                          create: (context) => EditProfileCubit()..getUserProfile(),
                                          child: EditProfileScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sported User",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(width: 4.0.w),
                                //edit name
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  constraints: BoxConstraints(
                                    maxHeight: 20.h,
                                    minHeight: 20.h,
                                    minWidth: 20.w,
                                    maxWidth: 20.w,
                                  ),
                                  icon: Icon(
                                    MdiIcons.clipboardEdit,
                                    color: Colors.white,
                                    size: 20.r,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider<EditProfileCubit>(
                                          create: (context) => EditProfileCubit()..getUserProfile(),
                                          child: EditProfileScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),

              //gender age sports
              Positioned(
                bottom: 0.0,
                child: ClipPath(
                  clipper: TrapeziumClipper(),
                  child: Container(
                    width: 1.sw,
                    height: 230.h,
                    color: Color(0xff25262C),
                    child: Padding(
                      padding: EdgeInsets.only(top: 96.h, left: 32.w, right: 32.w, bottom: 32.w),
                      child: BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, state) {
                          if (state is EditProfileLoadInProgress) {
                            return SpinKitRipple(color: Color(0xff8FD974));
                          }

                          if (state is EditProfileLoadSuccess) {
                            // print(state.userProfile.sportsPlayed.length);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //gender
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'GENDER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    Icon(
                                      state.userProfile.gender == "Male"
                                          ? MdiIcons.genderMale
                                          : state.userProfile.gender == "Female"
                                              ? MdiIcons.genderFemale
                                              : state.userProfile.gender == "Non-binary"
                                                  ? MdiIcons.genderNonBinary
                                                  : Icons.warning_amber_rounded,
                                      color: state.userProfile.gender == null ? Color(0xffF78179) : Color(0xff8FD974),
                                      size: 32.r,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      state.userProfile.gender == "Male"
                                          ? "Male"
                                          : state.userProfile.gender == "Female"
                                              ? 'Female'
                                              : state.userProfile.gender == "Non-binary"
                                                  ? 'Non-binary'
                                                  : "None",
                                      style: hintStyle,
                                    ),
                                  ],
                                ),

                                Container(height: 80.h, child: VerticalDivider(color: Color(0xff363740), thickness: 1.5.w, width: 40.w)),

                                //age
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'AGE RANGE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    state.userProfile.age == "above 40"
                                        ? Text(
                                            '40+',
                                            style: TextStyle(
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xff8FD974),
                                            ),
                                          )
                                        : state.userProfile.age != null
                                            ? Text(
                                                state.userProfile.age,
                                                style: TextStyle(
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xff8FD974),
                                                ),
                                              )
                                            : Icon(
                                                Icons.warning_amber_rounded,
                                                size: 32.r,
                                                color: Colors.amber,
                                              ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      state.userProfile.age == "10-15"
                                          ? "Early-teens"
                                          : state.userProfile.age == "15-20"
                                              ? 'Late-teens'
                                              : state.userProfile.age == "20-25"
                                                  ? 'Early-twenties'
                                                  : state.userProfile.age == "25-30"
                                                      ? 'Late-twenties'
                                                      : state.userProfile.age == "30-40"
                                                          ? 'Early-thirties'
                                                          : state.userProfile.age == "above 40"
                                                              ? 'Above 40'
                                                              : 'Not specified',
                                      style: hintStyle,
                                    ),
                                  ],
                                ),

                                Container(height: 80.h, child: VerticalDivider(color: Color(0xff363740), thickness: 1.5.w, width: 40.w)),

                                //sports
                                Column(
                                  children: [
                                    //title
                                    Text(
                                      'SPORTS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),

                                    //sports
                                    Row(
                                      children: [
                                        Container(
                                          width: 130.w,
                                          height: 90.h,
                                          child: BlocBuilder<EditProfileCubit, EditProfileState>(
                                            builder: (context, state) {
                                              if (state is EditProfileLoadSuccess) {
                                                return ListView.builder(
                                                  itemCount: state.userProfile.sportsPlayed.length,
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    final sport = state.userProfile.sportsPlayed[index];

                                                    return Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        //avi
                                                        ImageIcon(
                                                          AssetImage(
                                                            sport,
                                                          ),
                                                          color: Colors.white,
                                                          size: 18.r,
                                                        ),

                                                        SizedBox(height: 2.0.h),

                                                        //name
                                                        Text(
                                                          sport == "assets/icons/football_icon.png"
                                                              ? 'Football'
                                                              : sport == 'assets/icons/table_tennis_icon.png'
                                                                  ? 'Table Tennis'
                                                                  : sport == 'assets/icons/badminton_icon.png'
                                                                      ? 'Badminton'
                                                                      : sport == 'assets/icons/volleyball_icon.png'
                                                                          ? 'Volleyball'
                                                                          : sport == 'assets/icons/handball_icon.png'
                                                                              ? 'Handball'
                                                                              : sport == 'assets/icons/swimming_icon.png'
                                                                                  ? 'Swimming'
                                                                                  : sport == 'assets/icons/tennis_icon.png'
                                                                                      ? 'Tennis'
                                                                                      : sport == 'assets/icons/rugby_icon.png'
                                                                                          ? 'Rugby'
                                                                                          : sport == 'assets/icons/cricket_icon.png'
                                                                                              ? 'Cricket'
                                                                                              : sport == 'assets/icons/basketball_icon.png'
                                                                                                  ? 'Basketball'
                                                                                                  : '',
                                                          style: hintStyle,
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                              return Container();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }

                          if (state is EditProfileLoadFailure) {
                            return Container();
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),

          //details
          DefaultTabController(
            length: 2,
            child: Container(
              height: 371.h,
              width: 1.sw,
              child: Column(
                children: <Widget>[
                  //tabs
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      width: 170.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff25262C),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: ButtonsTabBar(
                        backgroundColor: Color(0xff8FD974),
                        height: 32.h,
                        duration: 0,
                        radius: 4.r,
                        buttonMargin: EdgeInsets.all(2.r),
                        physics: NeverScrollableScrollPhysics(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        unselectedBackgroundColor: Color(0xff25262C),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        unselectedLabelStyle: labelStyle.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        tabs: [
                          Tab(text: 'Profile'),
                          Tab(text: 'Stats'),
                        ],
                      ),
                    ),
                  ),

                  //details
                  Expanded(
                    child: TabBarView(
                      children: [
                        //profile
                        Column(
                          children: [
                            SizedBox(height: 20.h),

                            Divider(color: Color(0xff2C2D35), thickness: 2.h),

                            //details
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.0.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //first section
                                  Container(
                                    width: 166.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   'DATE OF BIRTH',
                                        //   style: TextStyle(
                                        //     color: Color(0xff707070),
                                        //     fontSize: 15.sp,
                                        //     fontWeight: FontWeight.w300,
                                        //   ),
                                        // ),
                                        // SizedBox(height: 10.h),
                                        // Text(
                                        //   '25 JANUARY 1992',
                                        //   style: TextStyle(
                                        //     color: Color(0xff8FD974),
                                        //     fontSize: 16.sp,
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
                                        // SizedBox(height: 30.h),
                                        Text(
                                          'JOINED SPORTED',
                                          style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          joinedSported.toUpperCase(),
                                          style: TextStyle(
                                            color: Color(0xff8FD974),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //divider
                                  Container(height: 120.h, child: VerticalDivider(color: Color(0xff2C2D35), thickness: 1.5.w, width: 0.0)),
                                  Spacer(),
                                  //second section
                                  BlocBuilder<EditProfileCubit, EditProfileState>(
                                    builder: (_, state) {
                                      if (state is EditProfileLoadSuccess) {
                                        return Container(
                                          width: 146.w,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 20.w),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'CLUBS',
                                                    style: TextStyle(
                                                      color: Color(0xff707070),
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                                  ),
                                                  state.userProfile.clubA == null || state.userProfile.clubA == 'None' ? SizedBox.shrink() : SizedBox(height: 10.h),
                                                  state.userProfile.clubA == null || state.userProfile.clubA == 'None'
                                                      ? Container()
                                                      : Text(
                                                          state.userProfile.clubA,
                                                          style: TextStyle(
                                                            color: Color(0xff8FD974),
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                  state.userProfile.clubB == null || state.userProfile.clubB == 'None' ? SizedBox.shrink() : SizedBox(height: 10.h),
                                                  state.userProfile.clubB == null || state.userProfile.clubB == 'None'
                                                      ? Container()
                                                      : Text(
                                                          state.userProfile.clubB,
                                                          style: TextStyle(
                                                            color: Color(0xff8FD974),
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                  state.userProfile.clubC == null || state.userProfile.clubC == 'None' ? SizedBox.shrink() : SizedBox(height: 10.h),
                                                  state.userProfile.clubC == null || state.userProfile.clubC == 'None'
                                                      ? Container()
                                                      : Text(
                                                          state.userProfile.clubC,
                                                          style: TextStyle(
                                                            color: Color(0xff8FD974),
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      if (state is EditProfileLoadFailure) {
                                        return Container();
                                      }
                                      return Container(
                                        width: 146.w,
                                        child: SpinKitRipple(
                                          color: Color(0xff8FD974),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            //divider
                            Divider(color: Color(0xff2C2D35), thickness: 2.h),

                            SizedBox(height: 20.h),

                            //certs title
                            Padding(
                              padding: EdgeInsets.only(left: 32.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Coaching Certifications',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

                            //certs list
                            Padding(
                              padding: EdgeInsets.only(left: 40.w),
                              child: Column(
                                children: [
                                  BlocBuilder<EditProfileCubit, EditProfileState>(
                                    builder: (_, state) {
                                      if (state is EditProfileLoadSuccess) {
                                        if (state.userProfile.pasteUrl != null) {
                                          return Row(
                                            children: [
                                              //indicator
                                              Icon(
                                                MdiIcons.circleOutline,
                                                size: 10.r,
                                                color: Color(0xff9BEB81),
                                              ),

                                              SizedBox(width: 10.w),

                                              //cert
                                              SizedBox(
                                                width: 300.w,
                                                child: Text(
                                                  state.userProfile.pasteUrl,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Color(0xBF707070),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else
                                          return Container();
                                      }

                                      if (state is EditProfileLoadFailure) {
                                        return Container();
                                      }
                                      return Container();
                                    },
                                  ),
                                  SizedBox(height: 10.0.h),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            Divider(color: Color(0xff2C2D35), thickness: 2.h),
                          ],
                        ),
                        //stats
                        Column(
                          children: [
                            SizedBox(height: 20.h),

                            // //biography title
                            // Text('Bo'),
                            //
                            // //bio
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                            //   child: Text(''),
                            // ),

                            SizedBox(height: 20.h),

                            //divider
                            Divider(color: Color(0xff2C2D35), thickness: 2.h),

                            SizedBox(height: 20.h),

                            //details
                            Row(
                              children: [
                                //first section
                                Column(
                                  children: [],
                                ),

                                //divider
                                Container(height: 40.h, child: VerticalDivider(color: Color(0xff2C2D35), width: 1.w)),

                                //second section
                                Column(
                                  children: [],
                                ),
                              ],
                            ),

                            SizedBox(height: 20.h),

                            //divider
                            Divider(color: Color(0xff2C2D35), thickness: 2.h),

                            //certs title
                            Text(''),

                            //certs list
                            Container(
                              height: 100.h,
                            ),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //red zone
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 40.h,
                      color: Color(0x1AF44336),
                      minWidth: 112.w,
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0x80F44336),
                          width: 1.5.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0.0,
                      hoverElevation: 0,
                      disabledElevation: 0,
                      highlightElevation: 0,
                      focusElevation: 0,
                      child: isLoggingOut == false
                          ? Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
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
                        final logmessage = await context.read<AuthenticationService>().signOut();
                        if (logmessage == "Signed Out Successfully") {
                          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
                          this._showToast(context, "Signing Out...");
                          Future.delayed(Duration(seconds: 2), () {
                            // 5s over, navigate
                            Navigator.of(context).pushReplacement(
                              Authenticate.route(),
                            );
                          });
                        } else {
                          this._showToast(context, "Signing Out Failed.");
                        }
                      },
                    ),
                  ],
                ),
                Container(height: 40.h, child: VerticalDivider(color: Color(0xff2C2D35), thickness: 2.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 40.h,
                      color: Color(0x1AF44336),
                      minWidth: 112.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0x80F44336),
                          width: 1.5.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0.0,
                      hoverElevation: 0,
                      disabledElevation: 0,
                      highlightElevation: 0,
                      focusElevation: 0,
                      child: isLoggingOut == false
                          ? Text(
                              'Delete Account',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
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
                        final logmessage = await context.read<AuthRepo>().deleteAccountAndProfileData();
                        if (logmessage == "Deleted Successfully") {
                          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationDeleteRequested());
                          this._showToast(context, "Deleting Account...");
                          Future.delayed(Duration(seconds: 2), () {
                            // 5s over, navigate
                            Navigator.of(context).pushReplacement(
                              Authenticate.route(),
                            );
                          });
                        } else {
                          this._showToast(context, "Deleting account not successful! Please try again");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

//clipper
class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    //left - top point
    path.lineTo(0.0, 48.h);

    //right - top point
    path.lineTo(size.width, 0.0);

    // right - bottom  point
    path.lineTo(size.width, size.height.h);

    //left - bottom point
    path.lineTo(0.0, size.height.h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
