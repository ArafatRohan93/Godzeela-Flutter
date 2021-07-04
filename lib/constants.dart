import 'package:flutter/material.dart';

const String textFont = "DMSans";

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFFFFFFFF),
);

const kValueTextStyle =  TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  labelText: '',
  // errorStyle: TextStyle(color: Colors.black),
  // errorBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.0,)),
  labelStyle: TextStyle(color: Colors.black54, fontSize: 16.0,fontFamily: textFont),
  hintStyle: TextStyle(color: Colors.black54, fontSize: 16.0,fontFamily: textFont),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    // borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    // borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    // borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  fillColor: Color(0xFFFBFBFB)
);