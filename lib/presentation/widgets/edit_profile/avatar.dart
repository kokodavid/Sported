import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  const Avatar({this.avatarUrl});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: avatarUrl == null
          ? Icon(
              Icons.person_rounded,
              color: Color(0xff31323B),
              size: 155.0.r,
            )
          : CircleAvatar(
              radius: 155.0.r,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(avatarUrl),
            ),
    );
  }
}
