import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/constants/constants.dart';
import 'package:sported_app/presentation/shared/filter_chips/custom_chip_content.dart';
import 'package:sported_app/presentation/widgets/edit_profile/select_level_dialog.dart';

class SportsPlayedSection extends StatefulWidget {
  @override
  _SportsPlayedSectionState createState() => _SportsPlayedSectionState();
}

class _SportsPlayedSectionState extends State<SportsPlayedSection> {
  // multiple choice value
  List<String> tags = [];

  // row 1
  List<String> options = [
    'assets/icons/football_icon.png',
    'assets/icons/cricket_icon.png',
    'assets/icons/badminton_icon.png',
    'assets/icons/basketball_icon.png',
    'assets/icons/tennis_icon.png',
  ];

  // row 2
  List<String> options2 = [
    'assets/icons/swimming_icon.png',
    'assets/icons/volleyball_icon.png',
    'assets/icons/rugby_icon.png',
    'assets/icons/table_tennis_icon.png',
    'assets/icons/handball_icon.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What sports do you play?',
                style: regularStyle,
              ),
            ),

            SizedBox(height: 20.h),

            //first row
            CustomChipContent(
              child: ChipsChoice<String>.multiple(
                value: tags,
                onChanged: (val) => setState(() => tags = val),
                choiceItems: C2Choice.listFrom<String, String>(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                choiceBuilder: (item) {
                  return AnimatedContainer(
                    width: 42.h,
                    height: 42.h,
                    margin: EdgeInsets.only(right: 10.w),
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.selected ? Color(0xff8FD974) : Color(0xff31323B),
                    ),
                    child: InkWell(
                      onTap: () {
                        item.select(!item.selected);
                        if (!item.selected) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => SelectLevelDialog(),
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: item.selected,
                            child: ImageIcon(
                              AssetImage(item.label),
                              size: 24.r,
                              color: item.selected ? Color(0xff28282B) : Colors.white,
                            ),
                          ),
                          ImageIcon(
                            AssetImage(item.label),
                            size: 24.r,
                            color: item.selected ? Color(0xff28282B) : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.h),

            //second row
            CustomChipContent(
              child: ChipsChoice<String>.multiple(
                value: tags,
                onChanged: (val) => setState(() => tags = val),
                choiceItems: C2Choice.listFrom<String, String>(
                  source: options2,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                choiceBuilder: (item) {
                  return AnimatedContainer(
                    width: 42.h,
                    height: 42.h,
                    margin: EdgeInsets.only(right: 10.w),
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.selected ? Color(0xff8FD974) : Color(0xff31323B),
                    ),
                    child: InkWell(
                      onTap: () {
                        item.select(!item.selected);
                        if (!item.selected) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => SelectLevelDialog(),
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: item.selected,
                            child: ImageIcon(
                              AssetImage(item.label),
                              size: 24.r,
                              color: item.selected ? Color(0xff28282B) : Colors.white,
                            ),
                          ),
                          ImageIcon(
                            AssetImage(item.label),
                            size: 24.r,
                            color: item.selected ? Color(0xff28282B) : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.0.h),

            //divider
            Divider(height: 1.h, thickness: 1.0.h, color: Color(0xff2E2D2D)),

            SizedBox(height: 20.0.h),
          ],
        ),
      ),
    );
  }
}
