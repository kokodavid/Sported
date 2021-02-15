import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sported_app/helper/authenticate.dart';
import 'package:sported_app/locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xff1F1F1F),
      ),
      home: Authenticate(),
    );
  }
}

