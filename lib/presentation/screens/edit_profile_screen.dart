import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sported_app/business_logic/blocs/nav_bloc/nav_bloc.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/data/models/ourUser.dart';
import 'package:sported_app/presentation/shared/form_input_decoration.dart';
import 'package:sported_app/presentation/widgets/edit_profile/avatar_section.dart';
import 'package:sported_app/shared/pages_switcher.dart';
import 'package:sported_app/view_controller/user_controller.dart';

import '../../locator.dart';

class EditProfileScreen extends StatefulWidget {
  static String route = "profile-view";

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    UserModel currentUser = await locator.get<UserController>().getUserFromDB();
    _currentUser = currentUser;

    setState(() {
      _username = _currentUser.username;
      _email = _currentUser.email;
    });
  }

  UserModel _currentUser;
  String _username;
  String _email;
  String empty = "loading....";
  String age, gender, club1, club2, club3, buddy, coach, urlPaste;
  bool buddyYes = false;
  bool buddyNo = false;
  bool coachYes = false;
  bool coachNo = false;

  TextEditingController fullNameTextEditingController;
  TextEditingController emailTextEditingController;
  TextEditingController pasteUrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editProfileFormKey = GlobalKey<FormState>();
    final ageFormKey = GlobalKey<FormState>();
    final genderFormKey = GlobalKey<FormState>();
    final sportsClubKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xff18181A),
          elevation: 0.0,
          centerTitle: true,
          //TODO: Implement leading on condition
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: KeyboardAvoider(
              autoScroll: true,
              focusPadding: 40.h,
              duration: Duration(milliseconds: 100),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Column(
                children: [
                  AvatarSection(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Form(
                      key: editProfileFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.0.h),
                          //full name title
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Full Name',
                              style: regularStyle,
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          //full name field
                          TextFormField(
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Color(0xff707070),
                            ),
                            controller: fullNameTextEditingController,
                            decoration: formInputDecoration(
                              hintText: _username ?? empty,
                              isDense: true,
                              // labelText: _username,
                              prefixIcon: Icons.person_outlined,
                            ),
                            validator: (val) {
                              return val.isEmpty || val.length < 2 ? "Try another Username" : null;
                            },
                          ),
                          SizedBox(height: 20.0.h),
                          //email title
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: regularStyle,
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          //email field
                          TextFormField(
                            readOnly: true,
                            style: regularStyle,
                            controller: emailTextEditingController,
                            decoration: formInputDecoration(
                              // labelText: _email,
                              isDense: true,
                              hintText: _email ?? empty,
                              prefixIcon: Icons.mail_outlined,
                            ),
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Enter a valid Email";
                            },
                          ),
                          SizedBox(height: 20.0.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //age title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Age',
                                  style: regularStyle,
                                ),
                              ),

                              //age range dropdown
                              SizedBox(height: 10.0.h),
                              Form(
                                key: ageFormKey,
                                child: Container(
                                  width: 170.w,
                                  child: DropdownButtonFormField(
                                    elevation: 0,
                                    iconSize: 1.r,
                                    isDense: true,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xff8FD974),
                                    ),
                                    items: [
                                      '10-15',
                                      '15-20',
                                      '20-25',
                                      '25-30',
                                      '30-40',
                                      'above 40',
                                    ].map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(val),
                                        );
                                      },
                                    ).toList(),
                                    hint: age == null
                                        ? Text(
                                            'Age',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xff8FD974),
                                            ),
                                          )
                                        : Text(
                                            age,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xff8FD974),
                                            ),
                                          ),
                                    icon: Icon(
                                      MdiIcons.chevronDown,
                                      size: 15.r,
                                      color: Color(0xffC5C6C7),
                                    ),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      enabled: true,
                                      fillColor: Color(0xff31323B),
                                      filled: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        age = val;
                                      });
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.0.h),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //age title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Gender',
                                  style: regularStyle,
                                ),
                              ),

                              //age range dropdown
                              SizedBox(height: 10.0.h),
                              Form(
                                key: genderFormKey,
                                child: Container(
                                  width: 170.w,
                                  child: DropdownButtonFormField(
                                    elevation: 0,
                                    iconSize: 1.r,
                                    isDense: true,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xff8FD974),
                                    ),
                                    items: ['Male', 'Female', 'Other'].map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(val),
                                        );
                                      },
                                    ).toList(),
                                    hint: gender == null
                                        ? Text(
                                            'Gender',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xff8FD974),
                                            ),
                                          )
                                        : Text(
                                            gender,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                    icon: Icon(
                                      MdiIcons.chevronDown,
                                      size: 15.r,
                                      color: Color(0xffC5C6C7),
                                    ),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      enabled: true,
                                      fillColor: Color(0xff31323B),
                                      filled: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      gender = val;
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.0.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        //title
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Are you a member of a sports club?',
                            style: regularStyle,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        //forms
                        Form(
                          key: sportsClubKey,
                          child: Column(
                            children: [
                              //club 1
                              DropdownButtonFormField(
                                elevation: 0,
                                iconSize: 23.r,
                                isDense: true,
                                isExpanded: false,
                                hint: club1 == null
                                    ? Text('Please select a sports club', style: labelStyle)
                                    : Text(
                                        club1,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color(0xff8FD974),
                                        ),
                                      ),
                                icon: Icon(
                                  MdiIcons.chevronDown,
                                  color: Color(0xffC5C6C7),
                                ),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xff8FD974),
                                ),
                                items: [
                                  'No',
                                  'NJSC',
                                  'Karen tennis',
                                  'Aga khan',
                                  'Oshwal Centre',
                                  'Jaffery Turf',
                                  'Arena One',
                                  'Gym Khana',
                                  'Sikh Union',
                                  'Parklands Sports club',
                                  'Impala Club'
                                ].map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                decoration: InputDecoration(
                                  enabled: true,
                                  fillColor: Color(0xff31323B),
                                  filled: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    club1 = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField(
                                elevation: 0,
                                iconSize: 23.r,
                                isDense: true,
                                isExpanded: false,
                                hint: club2 == null
                                    ? Text('Please select a sports club', style: labelStyle)
                                    : Text(
                                        club2,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color(0xff8FD974),
                                        ),
                                      ),
                                icon: Icon(
                                  MdiIcons.chevronDown,
                                  color: Color(0xffC5C6C7),
                                ),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xff8FD974),
                                ),
                                items: [
                                  'No',
                                  'NJSC',
                                  'Karen tennis',
                                  'Aga khan',
                                  'Oshwal Centre',
                                  'Jaffery Turf',
                                  'Arena One',
                                  'Gym Khana',
                                  'Sikh Union',
                                  'Parklands Sports club',
                                  'Impala Club'
                                ].map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                decoration: InputDecoration(
                                  enabled: true,
                                  fillColor: Color(0xff31323B),
                                  filled: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    club2 = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField(
                                elevation: 0,
                                iconSize: 23.r,
                                isDense: true,
                                isExpanded: false,
                                hint: club3 == null
                                    ? Text('Please select a sports club', style: labelStyle)
                                    : Text(
                                        club3,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color(0xff8FD974),
                                        ),
                                      ),
                                icon: Icon(
                                  MdiIcons.chevronDown,
                                  color: Color(0xffC5C6C7),
                                ),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xff8FD974),
                                ),
                                items: [
                                  'No',
                                  'NJSC',
                                  'Karen tennis',
                                  'Aga khan',
                                  'Oshwal Centre',
                                  'Jaffery Turf',
                                  'Arena One',
                                  'Gym Khana',
                                  'Sikh Union',
                                  'Parklands Sports club',
                                  'Impala Club'
                                ].map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                decoration: InputDecoration(
                                  enabled: true,
                                  fillColor: Color(0xff31323B),
                                  filled: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                onChanged: (val) {
                                  club3 = val;
                                },
                              ),
                              SizedBox(height: 20),
                              //divider
                              Divider(height: 1.h, thickness: 1.0.h, color: Color(0xff2E2D2D)),

                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        //padded content
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              //title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Are you willing to sport with others?',
                                  style: regularStyle,
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              //sub
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sported is platform that can help you find players to sport with!',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Color(0xff8FD974),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              //btns
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //yes
                                  MaterialButton(
                                    height: 30.h,
                                    color: buddyYes ? Color(0xff8FD974) : Color(0xff31323B),
                                    minWidth: 56.w,
                                    padding: EdgeInsets.all(0),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: Color(0xff3E3E3E),
                                      ),
                                    ),
                                    elevation: 0.0,
                                    hoverElevation: 0,
                                    disabledElevation: 0,
                                    highlightElevation: 0,
                                    focusElevation: 0,
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: Color(0xff707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        buddy = "Yes";
                                        buddyYes = !buddyYes;
                                      });
                                      print("Yes");
                                    },
                                  ),
                                  SizedBox(width: 12.0.w),
                                  MaterialButton(
                                    height: 30.h,
                                    color: buddyNo ? Color(0xff8FD974) : Color(0xff31323B),
                                    minWidth: 56.w,
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: Color(0xff3E3E3E),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(0),
                                    elevation: 0.0,
                                    hoverElevation: 0,
                                    disabledElevation: 0,
                                    highlightElevation: 0,
                                    focusElevation: 0,
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        color: Color(0xff707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        buddy = "No";
                                        buddyNo = !buddyNo;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0.h),
                              //etc
                              Text(
                                'We will only let other Sported users find you if you are willing to be found and matched according to sporting interests',
                                style: hintStyle.copyWith(fontSize: 11.sp),
                              ),
                              SizedBox(height: 20.0.h),
                            ],
                          ),
                        ),
                        //divider
                        Divider(height: 1.h, thickness: 1.0.h, color: Color(0xff2E2D2D)),
                        SizedBox(height: 20.0.h),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //padded content
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Are you able to train someone who is looking to learn?',
                                  style: regularStyle,
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              //btns
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //yes
                                  MaterialButton(
                                    height: 30.h,
                                    color: coachYes ? Color(0xff8FD974) : Color(0xff31323B),
                                    minWidth: 56.w,
                                    padding: EdgeInsets.all(0),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: Color(0xff3E3E3E),
                                      ),
                                    ),
                                    elevation: 0.0,
                                    hoverElevation: 0,
                                    disabledElevation: 0,
                                    highlightElevation: 0,
                                    focusElevation: 0,
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: Color(0xff707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        coach = "Yes";
                                        coachYes = !coachYes;
                                      });
                                      print("Yes");
                                    },
                                  ),
                                  SizedBox(width: 12.0.w),
                                  MaterialButton(
                                    height: 30.h,
                                    color: coachNo ? Color(0xff8FD974) : Color(0xff31323B),
                                    minWidth: 56.w,
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: Color(0xff3E3E3E),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(0),
                                    elevation: 0.0,
                                    hoverElevation: 0,
                                    disabledElevation: 0,
                                    highlightElevation: 0,
                                    focusElevation: 0,
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        color: Color(0xff707070),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        coach = "No";
                                        coachNo = !coachNo;
                                      });
                                      print("Yes");
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0.h),
                              //etc
                              RichText(
                                text: TextSpan(
                                  text:
                                      'Do you hold any certifications or credentials to be able to coach?',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Color(0xff8FD974),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' If you do, please share a link to your portfolio.',
                                      style: hintStyle.copyWith(fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: TextFormField(
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 15.sp,
                                  ),
                                  controller: pasteUrl,
                                  decoration: formInputDecoration(
                                    isDense: true,
                                    hintText: 'Paste URL',
                                    prefixIcon: Icons.link,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0.h),
                            ],
                          ),
                        ),
                        //divider
                        Divider(height: 1.h, thickness: 1.0.h, color: Color(0xff2E2D2D)),
                        SizedBox(height: 20.0.h),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      //btn
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            height: 30.h,
                            color: Color(0xff8FD974),
                            minWidth: 112.w,
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0.0,
                            hoverElevation: 0,
                            disabledElevation: 0,
                            highlightElevation: 0,
                            focusElevation: 0,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                            ),
                            onPressed: () async {
                              //TODO: Implement save profile
                              await createUserProfile();

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider<NavBloc>(
                                    create: (context) => NavBloc()..add(LoadPageThree()),
                                    child: PagesSwitcher(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 20.0.h),
                    ],
                  )
                ],
              )
              // child: CustomScrollView(
              //   controller: _scrollController,
              //   slivers: [
              //     SliverList(
              //       delegate: SliverChildListDelegate(
              //         [
              //           //avi section
              //           AvatarSection(),
              //           //forms
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              //             child: Form(
              //               key: editProfileFormKey,
              //               child: Column(
              //                 children: [
              //                   SizedBox(height: 10.0.h),
              //                   //full name title
              //                   Align(
              //                     alignment: Alignment.centerLeft,
              //                     child: Text(
              //                       'Full Name',
              //                       style: regularStyle,
              //                     ),
              //                   ),
              //                   SizedBox(height: 10.0.h),
              //                   //full name field
              //                   TextFormField(
              //                     style: TextStyle(
              //                       fontSize: 15.sp,
              //                       color: Color(0xff707070),
              //                     ),
              //                     controller: fullNameTextEditingController,
              //
              //                     decoration: formInputDecoration(
              //                       hintText: "",
              //                       isDense: true,
              //                       labelText: _username,
              //                       prefixIcon: Icons.person_outlined,
              //                     ),
              //                     validator: (val) {
              //                       return val.isEmpty || val.length < 2 ? "Try another Username" : null;
              //                     },
              //                   ),
              //                   SizedBox(height: 20.0.h),
              //                   //email title
              //                   Align(
              //                     alignment: Alignment.centerLeft,
              //                     child: Text(
              //                       'Email',
              //                       style: regularStyle,
              //                     ),
              //                   ),
              //                   SizedBox(height: 10.0.h),
              //                   //email field
              //                   TextFormField(
              //                     style: regularStyle,
              //                     controller: emailTextEditingController,
              //                     decoration: formInputDecoration(
              //                       labelText: _email,
              //                       isDense: true,
              //                       hintText: "",
              //                       prefixIcon: Icons.mail_outlined,
              //                     ),
              //                     validator: (val) {
              //                       return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter a valid Email";
              //                     },
              //                   ),
              //                   SizedBox(height: 20.0.h),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           //age
              //           Row(
              //             children: <Widget>[
              //               Expanded(child: Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     //age title
              //                     Align(
              //                       alignment: Alignment.centerLeft,
              //                       child: Text(
              //                         'Age',
              //                         style: regularStyle,
              //                       ),
              //                     ),
              //
              //                     //age range dropdown
              //                     SizedBox(height: 10.0.h),
              //                     Form(
              //                       key: editProfileFormKey,
              //                       child: Container(
              //                         width: 170.w,
              //                         child: DropdownButtonFormField(
              //                           elevation: 0,
              //                           iconSize: 1.r,
              //                           onChanged: (val) {
              //
              //                           },
              //                           isDense: true,
              //                           style: TextStyle(
              //                             fontSize: 15.sp,
              //                             color: Color(0xff8FD974),
              //                           ),
              //                           items: ['10-15', '15-20', '20-25','25-30','30-40','above 40',].map(
              //                                 (val) {
              //                               return DropdownMenuItem<String>(
              //                                 value: val,
              //                                 child: Text(val),
              //                               );
              //                             },
              //                           ).toList(),
              //                           hint: age == null ? Text('Age',style: TextStyle(
              //                             fontSize: 15.sp,
              //                             color: Color(0xff8FD974),
              //                           ),):Text(age),
              //                           icon: Icon(
              //                             MdiIcons.chevronDown,
              //                             size: 15.r,
              //                             color: Color(0xffC5C6C7),
              //                           ),
              //                           decoration: InputDecoration(
              //                             alignLabelWithHint: true,
              //                             enabled: true,
              //                             fillColor: Color(0xff31323B),
              //                             filled: true,
              //                             border: UnderlineInputBorder(
              //                               borderSide: BorderSide.none,
              //                               borderRadius: BorderRadius.circular(8.r),
              //                             ),
              //                             enabledBorder: UnderlineInputBorder(
              //                               borderSide: BorderSide.none,
              //                               borderRadius: BorderRadius.circular(8.r),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //
              //                     SizedBox(height: 20.0.h),
              //                   ],
              //                 ),
              //               ),),
              //               Expanded(child: GenderSection()),
              //             ],
              //           ),
              //           //sports clubs
              //           SportsClubsSection(),
              //           //willingness
              //           WillingnessPrompt(),
              //           //coaching
              //           CoachingPrompt(),
              //           //save
              //           SaveProfileBtn(),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              ),
        ),
      ),
    );
  }

  createUserProfile() async {
    try {
      await locator.get<UserController>().uploadProfile(
          age: age,
          clubC: club3,
          clubB: club2,
          clubA: club1,
          coach: coach,
          buddy: buddy,
          gender: gender,
          pasteUrl: pasteUrl.text);
      print("Age:" + age);
      print("Url:" + pasteUrl.text);
    } catch (e) {
      print("Error:" + e.toString());
    }
  }
}
