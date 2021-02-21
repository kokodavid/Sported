import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sported_app/helper/authenticate.dart';
import 'package:sported_app/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 736),
      allowFontScaling: false,
      builder: () => MaterialApp(
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Color(0x1a8fd974),
          scaffoldBackgroundColor: Color(0xff18181A),
        ),
        home: Authenticate(),
      ),
    );
  }
}
