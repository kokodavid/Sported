// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sported_app/constants/constants.dart';
// import 'package:sported_app/models/ourUser.dart';
// import 'package:sported_app/services/authentication_service.dart';
// import 'package:sported_app/view_controller/user_controller.dart';
//
// import '../../../locator.dart';
// import '../../shared/form_input_decoration.dart';
//
// class EditProfileForms extends StatefulWidget {
//
//   @override
//   _EditProfileFormsState createState() => _EditProfileFormsState();
//
// }
//
// class _EditProfileFormsState extends State<EditProfileForms> {
//   UserModel _currentUser;
//   String _username;
//   String _email;
//   String email,name;
//
//   @override
//   void initState() {
//     getUser();
//     super.initState();
//   }
//   void getUser()async{
//     UserModel currentUser = await locator.get<UserController>().getUserFromDB();
//     _currentUser = currentUser;
//
//     setState(() {
//       _username = _currentUser.username;
//       _email = _currentUser.email;
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final editProfileFormKey = GlobalKey<FormState>();
//     TextEditingController fullNameTextEditingController ;
//     TextEditingController emailTextEditingController;
//     // addStringToSF(fullName: fullNameTextEditingController.text,mail: emailTextEditingController.text);
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//       child: Form(
//         onChanged: () {},
//         key: editProfileFormKey,
//         child: Column(
//           children: [
//             SizedBox(height: 10.0.h),
//             //full name title
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Full Name',
//                 style: regularStyle,
//               ),
//             ),
//             SizedBox(height: 10.0.h),
//             //full name field
//             TextFormField(
// <<<<<<< HEAD:lib/presentation/widgets/edit_profile/edit_profile_forms.dart
//               onChanged: (val) {
//                 // print(val);
//                 // print(fullNameTextEditingController.text);
//               },
//               controller: fullNameTextEditingController,
// =======
// >>>>>>> fixes:lib/widgets/edit_profile/edit_profile_forms.dart
//               style: TextStyle(
//                 fontSize: 15.sp,
//                 color: Color(0xff707070),
//               ),
//               controller: fullNameTextEditingController,
//
//               decoration: formInputDecoration(
//                 hintText: "",
//                 isDense: true,
// <<<<<<< HEAD:lib/presentation/widgets/edit_profile/edit_profile_forms.dart
// <<<<<<< HEAD:lib/presentation/widgets/edit_profile/edit_profile_forms.dart
//                 // labelText: _currentUser.email,
// =======
//                 labelText: _currentUser.username,
// >>>>>>> Refactored Authentication and Getting User Info:lib/widgets/edit_profile/edit_profile_forms.dart
// =======
//                 labelText: _username,
// >>>>>>> fixes:lib/widgets/edit_profile/edit_profile_forms.dart
//                 prefixIcon: Icons.person_outlined,
//               ),
//               validator: (val) {
//                 return val.isEmpty || val.length < 2 ? "Try another Username" : null;
//               },
//             ),
//             SizedBox(height: 20.0.h),
//             //email title
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Email',
//                 style: regularStyle,
//               ),
//             ),
//             SizedBox(height: 10.0.h),
//             //email field
//             TextFormField(
//               style: regularStyle,
//               controller: emailTextEditingController,
//               decoration: formInputDecoration(
// <<<<<<< HEAD:lib/presentation/widgets/edit_profile/edit_profile_forms.dart
//                 // labelText: _currentUser.email,
// =======
//                 labelText: _email,
// >>>>>>> fixes:lib/widgets/edit_profile/edit_profile_forms.dart
//                 isDense: true,
//                 hintText: "",
//                 prefixIcon: Icons.mail_outlined,
//               ),
//               validator: (val) {
//                 return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter a valid Email";
//               },
//             ),
//             SizedBox(height: 20.0.h),
//           ],
//         ),
//       ),
//     );
//
//   }
//
//   addStringToSF({String mail,String fullName}) async {
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences preferences = await _prefs;
//     var _res = preferences.setString("name", fullName);
//     return _res;
//   }
//
//
//
//
// }
