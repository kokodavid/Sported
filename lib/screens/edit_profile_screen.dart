import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:sported_app/widgets/edit_profile/age_section.dart';
import 'package:sported_app/widgets/edit_profile/avatar_section.dart';
import 'package:sported_app/widgets/edit_profile/coaching_prompt.dart';
import 'package:sported_app/widgets/edit_profile/edit_profile_forms.dart';
import 'package:sported_app/widgets/edit_profile/save_profile_btn.dart';
import 'package:sported_app/widgets/edit_profile/sports_clubs_section.dart';
import 'package:sported_app/widgets/edit_profile/willingness_prompt.dart';

class EditProfileScreen extends StatefulWidget {
  static String route = "profile-view";

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
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
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      //avi section
                      AvatarSection(),

                      //forms
                      EditProfileForms(),

                      //age
                      AgeSection(),

                      //sports clubs
                      SportsClubsSection(),

                      //willingness
                      WillingnessPrompt(),

                      //coaching
                      CoachingPrompt(),

                      //save
                      SaveProfileBtn(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
