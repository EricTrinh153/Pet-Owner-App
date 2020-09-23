import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:pet_uicomponent/Screens/MainScreen/main_screen.dart';
import 'package:pet_uicomponent/constants.dart';
import 'package:pet_uicomponent/user_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoreInfo extends StatefulWidget {
  final phoneOrEmailHandler;
  final ageCheckHandler;
  MoreInfo({Key key, @required this.phoneOrEmailHandler, this.ageCheckHandler})
      : super(key: key);
  @override
  Body createState() => Body();
  // Widget build(BuildContext context) {
  //   return Scaffold(

  //     resizeToAvoidBottomPadding: false,
  //     body: Body(
  //     ),
  //   );
  // }
}

Future<UserModel> createUser(
    String name, String phoneOrEmail, bool ageCheck, String deviceInfo) async {
  final String apiUrl =
      "http://alpha.futurethink.net.au/petname?token=BsNoZJBM4QN8r8f";
  final Map<String, dynamic> data = {
    "full_name": name,
    "phone": phoneOrEmail,
    "confirmed_age_over_13": ageCheck,
    "device_id": deviceInfo
  };
  print(data);
  final jsonEncoder = new JsonEncoder();
  final http.Response response = await http.post(Uri.encodeFull(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncoder.convert({
        "full_name": name,
        "phone": phoneOrEmail,
        "confirmed_age_over_13": ageCheck,
        "device_id": deviceInfo
      }));
  if (response.statusCode == 201) {
    final String responseString = response.body;
    print("passsed" + response.body);
    return userModelFromJson(responseString);
  } else {
    print("failed" + response.body);
    return null;
  }
}

class Body extends State<MoreInfo> {
  final nameController = TextEditingController();
  static String phoneOrEmail;
  static bool ageCheck;
  // DeviceInfoPlugin deviceInforPlugin=DeviceInfoPlugin();
  UserModel _user;
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildname() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          labelText: "Your name",
          labelStyle: TextStyle(color: linkColor),
          enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(color: linkColor))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }
      },
    );
  }

  Widget _buildcity() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Your city",
          labelStyle: TextStyle(color: linkColor),
          enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(color: linkColor))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is required';
        }
      },
    );
  }

  Widget _buildpet() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Do you have a pet? What is it name?",
          labelStyle: TextStyle(color: linkColor),
          enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(color: linkColor))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pet validation is required';
        }
      },
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "TELL US MORE ABOUT YOU",
                  style: TextStyle(fontSize: 17.0, color: activemenuColor),
                ),
                Image.asset(
                  "assets/images/avatar.png",
                  height: size.height * 0.2,
                ),
                Container(
                    padding: EdgeInsets.all(20.0),
                    width: 600.0,
                    margin: const EdgeInsets.only(right: 25, left: 25),
                    child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          _buildname(),
                          _buildcity(),
                          _buildpet(),
                          SizedBox(
                            height: 20,
                          ),
                          _user == null
                              ? Container()
                              : Text('Your id ${_user.id} and Your qr_id${_user.qrId}'),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 119),
                            color: linkColor,
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) {
                                return;
                              } else {
                                // IosDeviceInfo iosInfo =await deviceInforPlugin.iosInfo;
                                final String deviceInfo = "356938035643809";
                                final String phoneOrEmail =
                                    widget.phoneOrEmailHandler;
                                final bool ageCheckHandler =
                                    widget.ageCheckHandler;
                                final String name = nameController.text;
                                print(phoneOrEmail);
                                print(name);
                                print(ageCheckHandler);

                                final UserModel user = await createUser(name,
                                    phoneOrEmail, ageCheckHandler, deviceInfo);
                                setState(() {
                                  _user = user;
                                });
                                // print('${_user.qrId}');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return MainScreen();
                                //     },
                                //   ),
                                // );

                              }
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Align(
                            child: FlatButton(
                                child: Text("Skip",
                                    style: TextStyle(
                                      color: activemenuColor,
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MainScreen();
                                      },
                                    ),
                                  );
                                }),
                            alignment: Alignment.bottomRight,
                          ),
                        ]))),
              ]),
        ));
  }
}
