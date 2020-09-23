import 'package:flutter/material.dart';
import 'package:pet_uicomponent/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon:Icon(Icons.menu,color:activemenuColor,), 
          onPressed:(){} 
          ),
        title: TextField(
          decoration: InputDecoration(
          hintText:'Search',
          hintStyle: TextStyle(color: annotationColor),
          enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(color: activemenuColor))),
        ),
        actions: <Widget>[
          IconButton(
            icon:Image.asset("assets/images/avatar.png"), 
            onPressed: null
            ),
          
        ],
      ),
    );
  }
}
