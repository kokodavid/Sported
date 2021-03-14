import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:sported_app/helper/authenticate.dart';
import 'package:sported_app/locator.dart';
import 'package:provider/provider.dart';
import 'package:sported_app/services/authentication_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        StreamProvider(
            create: (context) =>
            context.read<AuthenticationService>().authStateChanges),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 736),
        allowFontScaling: false,
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Color(0xff31323B),
            appBarTheme: AppBarTheme(
              color: Color(0xff18181A),
              actionsIconTheme: IconThemeData(
                color: Color(0xffBABABB),
              ),
              iconTheme: IconThemeData(
                color: Color(0xffBABABB),
              ),
              elevation: 0.0,
              brightness: Brightness.dark,
              centerTitle: true,
            ),
            accentColor: Color(0xff2F4826),
            splashColor: Colors.transparent,
            highlightColor: Color(0x1a2f4826),
            scaffoldBackgroundColor: Color(0xff18181A),
          ),
          home: Authenticate(),
        ),
      ),
    );
  }
}
