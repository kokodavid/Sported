import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      child: Container(
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Color(0xffBABABB)),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                MdiIcons.filterVariant,
                color: Color(0xffBABABB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
