// import 'package:flutter/material.dart';
//
// class ChangeProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
// 	    Padding(
// 		    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
// 		    child: Row(
// 			    children: <Widget>[
// 				    Expanded(
// 					    child: Column(
// 						    mainAxisAlignment: MainAxisAlignment.start,
// 						    crossAxisAlignment: CrossAxisAlignment.start,
// 						    children: [
// 							    //age title
// 							    Align(
// 								    alignment: Alignment.centerLeft,
// 								    child: Text(
// 									    'Age',
// 									    style: regularStyle,
// 								    ),
// 							    ),
//
// 							    //age range dropdown
// 							    SizedBox(height: 10.0.h),
// 							    Form(
// 								    key: ageFormKey,
// 								    child: Container(
// 									    width: 170.w,
// 									    child: DropdownButtonFormField(
// 										    elevation: 0,
// 										    iconSize: 1.r,
// 										    isDense: true,
// 										    style: TextStyle(
// 											    fontSize: 15.sp,
// 											    color: Color(0xff8FD974),
// 										    ),
// 										    items: [
// 											    '10-15',
// 											    '15-20',
// 											    '20-25',
// 											    '25-30',
// 											    '30-40',
// 											    'above 40',
// 										    ].map(
// 													    (val) {
// 												    return DropdownMenuItem<String>(
// 													    value: val,
// 													    child: Text(val),
// 												    );
// 											    },
// 										    ).toList(),
// 										    hint: initialAge == null
// 												    ? BlocBuilder<EditProfileCubit, EditProfileState>(
// 											    builder: (context, state) {
// 												    if (state is EditProfileLoadSuccess) {
// 													    if (state.userProfile.age != null) {
// 														    return Text(
// 															    state.userProfile.age,
// 															    style: TextStyle(
// 																    fontSize: 15.sp,
// 																    color: Color(0xff8FD974),
// 															    ),
// 														    );
// 													    } else
// 														    return Text(
// 															    'Age',
// 															    style: TextStyle(
// 																    fontSize: 15.sp,
// 																    color: Color(0xff8FD974),
// 															    ),
// 														    );
// 												    } else
// 													    return Text(
// 														    "Agem",
// 														    style: TextStyle(
// 															    fontSize: 15.sp,
// 															    color: Color(0xff8FD974),
// 														    ),
// 													    );
// 											    },
// 										    )
// 												    : Text(
// 											    initialAge,
// 											    style: TextStyle(
// 												    fontSize: 15.sp,
// 												    color: Color(0xff8FD974),
// 											    ),
// 										    ),
// 										    icon: Icon(
// 											    MdiIcons.chevronDown,
// 											    size: 15.r,
// 											    color: Color(0xffC5C6C7),
// 										    ),
// 										    decoration: InputDecoration(
// 											    alignLabelWithHint: true,
// 											    enabled: true,
// 											    fillColor: Color(0xff31323B),
// 											    filled: true,
// 											    border: UnderlineInputBorder(
// 												    borderSide: BorderSide.none,
// 												    borderRadius: BorderRadius.circular(8.r),
// 											    ),
// 											    enabledBorder: UnderlineInputBorder(
// 												    borderSide: BorderSide.none,
// 												    borderRadius: BorderRadius.circular(8.r),
// 											    ),
// 										    ),
// 										    onChanged: (val) {
// 											    setState(() {
// 												    initialAge = val;
// 											    });
// 										    },
// 									    ),
// 								    ),
// 							    ),
//
// 							    SizedBox(height: 20.0.h),
// 						    ],
// 					    ),
// 				    ),
// 				    Expanded(
// 					    child: Column(
// 						    mainAxisAlignment: MainAxisAlignment.start,
// 						    crossAxisAlignment: CrossAxisAlignment.start,
// 						    children: [
// 							    //age title
// 							    Align(
// 								    alignment: Alignment.centerLeft,
// 								    child: Text(
// 									    'Gender',
// 									    style: regularStyle,
// 								    ),
// 							    ),
//
// 							    //age range dropdown
// 							    SizedBox(height: 10.0.h),
// 							    Form(
// 								    key: genderFormKey,
// 								    child: Container(
// 									    width: 170.w,
// 									    child: DropdownButtonFormField(
// 										    elevation: 0,
// 										    iconSize: 1.r,
// 										    isDense: true,
// 										    style: TextStyle(
// 											    fontSize: 15.sp,
// 											    color: Color(0xff8FD974),
// 										    ),
// 										    items: ['Male', 'Female', 'Other'].map(
// 													    (val) {
// 												    return DropdownMenuItem<String>(
// 													    value: val,
// 													    child: Text(val),
// 												    );
// 											    },
// 										    ).toList(),
// 										    hint: initialGender == null
// 												    ? Text(
// 											    'Gender',
// 											    style: TextStyle(
// 												    fontSize: 15.sp,
// 												    color: Color(0xff8FD974),
// 											    ),
// 										    )
// 												    : Text(
// 											    initialGender,
// 											    style: TextStyle(
// 												    fontSize: 15.sp,
// 											    ),
// 										    ),
// 										    icon: Icon(
// 											    MdiIcons.chevronDown,
// 											    size: 15.r,
// 											    color: Color(0xffC5C6C7),
// 										    ),
// 										    decoration: InputDecoration(
// 											    alignLabelWithHint: true,
// 											    enabled: true,
// 											    fillColor: Color(0xff31323B),
// 											    filled: true,
// 											    border: UnderlineInputBorder(
// 												    borderSide: BorderSide.none,
// 												    borderRadius: BorderRadius.circular(8.r),
// 											    ),
// 											    enabledBorder: UnderlineInputBorder(
// 												    borderSide: BorderSide.none,
// 												    borderRadius: BorderRadius.circular(8.r),
// 											    ),
// 										    ),
// 										    onChanged: (val) {
// 											    setState(() {
// 												    initialGender = val;
// 											    });
// 										    },
// 									    ),
// 								    ),
// 							    ),

//
// 							    SizedBox(height: 20.0.h),
// 						    ],
// 					    ),
// 				    ),
// 			    ],
// 		    ),
// 	    ),
//
//     );
//   }
// }

//  Form(
//                               key: genderFormKey,
//                               child: Container(
//                                 width: 170.w,
//                                 child: DropdownButtonFormField(
//                                   elevation: 0,
//                                   iconSize: 1.r,
//                                   isDense: true,
//                                   style: TextStyle(
//                                     fontSize: 15.sp,
//                                     color: Color(0xff8FD974),
//                                   ),
//                                   items: ['Male', 'Female', 'Other'].map(
//                                     (val) {
//                                       return DropdownMenuItem<String>(
//                                         value: val,
//                                         child: Text(val),
//                                       );
//                                     },
//                                   ).toList(),
//                                   hint: initialGender == null
//                                       ? Text(
//                                           'Gender',
//                                           style: TextStyle(
//                                             fontSize: 15.sp,
//                                             color: Color(0xff8FD974),
//                                           ),
//                                         )
//                                       : Text(
//                                           initialGender,
//                                           style: TextStyle(
//                                             fontSize: 15.sp,
//                                           ),
//                                         ),
//                                   icon: Icon(
//                                     MdiIcons.chevronDown,
//                                     size: 15.r,
//                                     color: Color(0xffC5C6C7),
//                                   ),
//                                   decoration: InputDecoration(
//                                     alignLabelWithHint: true,
//                                     enabled: true,
//                                     fillColor: Color(0xff31323B),
//                                     filled: true,
//                                     border: UnderlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(8.r),
//                                     ),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(8.r),
//                                     ),
//                                   ),
//                                   onChanged: (val) {
//                                     setState(() {
//                                       initialGender = val;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
