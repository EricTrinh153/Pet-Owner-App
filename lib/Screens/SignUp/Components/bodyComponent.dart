import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_uicomponent/Screens/MoreInfo/moreinfo.dart';
import 'package:pet_uicomponent/constants.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String result = "Hello";
  Future _scanQR() async {
    try {
      String qrResult = (await BarcodeScanner.scan()) as String;
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denined";
        });
      } else {
        setState(() {
          result = "Unknow error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the wrong button";
      });
    } catch (ex) {
      setState(() {
        result = "Unknow error $ex";
      });
    }
  }

  @override
  final age13Check = true;

  final phoneOrEmail = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildemailandphone() {
    return TextFormField(
      controller: phoneOrEmail,
      decoration: InputDecoration(
          labelText: 'Email or mobile',
          labelStyle: TextStyle(color: linkColor),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: linkColor))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mobile or email is required';
        }
        if (!RegExp(
                r"^(?:[+0]9)?[0-9]{10,12}$|[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)?")
            .hasMatch(value)) {
          return 'Please input a valid email or phone number';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool check = true;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                _scanQR();
              },
              child: Image.asset(
                "assets/images/qrbar.png",
                height: size.height * 0.2,
              )),
          Text(
            "Scan a Friend Tag",
            style: TextStyle(fontSize: 17.0, color: readonlyColor),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Sign up with your social account",
            style: TextStyle(fontSize: 17.0, color: readonlyColor),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/insta1.png",
                    )),
                GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/fb1.png",
                    )),
              ]),
          SizedBox(
            height: 20,
          ),
          Text(
            "or sign up with your email/mobile",
            style: TextStyle(fontSize: 17.0, color: readonlyColor),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            width: 600.0,
            margin: const EdgeInsets.only(right: 25, left: 25),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                _buildemailandphone(),
                ListTile(
                  title: Text("I agrreed with the Terms and Policy Privacy",
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  leading: Radio(
                    value: age13Check,
                    groupValue: check,
                    activeColor: linkColor,
                    onChanged: (val) {
                      setState(() => check = val);
                    },
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 119),
                  color: linkColor,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MoreInfo(
                              phoneOrEmailHandler: phoneOrEmail.text,
                              ageCheckHandler: age13Check,
                            );
                          },
                        ),
                      );
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Already have an account? ",
                style: TextStyle(fontSize: 17.0, color: readonlyColor)),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 17.0,
                    color: linkColor,
                    fontWeight: FontWeight.bold),
              ),
            )
          ])
        ],
      ),
    );
  }
}
