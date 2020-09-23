import 'package:flutter/material.dart';
import 'package:pet_uicomponent/Screens/SignUp/signup_screen.dart';
import 'package:pet_uicomponent/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet UI',
      theme: ThemeData(
        primaryColor: annotationColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SignupScreen(),
    );
  }
}

