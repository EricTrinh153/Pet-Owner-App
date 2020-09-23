import 'package:flutter/material.dart';
import 'package:pet_uicomponent/Screens/SignUp/Components/bodyComponent.dart';

class SignupScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Body(),
    );
  }
}