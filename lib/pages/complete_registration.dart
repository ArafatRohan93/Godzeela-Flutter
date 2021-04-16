import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/user_home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CompleteRegistration extends StatefulWidget {
  final UserCredential userCredential;
  CompleteRegistration({this.userCredential});

  @override
  _CompleteRegistrationState createState() => _CompleteRegistrationState();
}

class _CompleteRegistrationState extends State<CompleteRegistration> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;
  String username1 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Container(
                  height: 200.0,
                  child: SvgPicture.asset(
                    'assets/images/godzilla_logo.svg',
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Almost there!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Enter an username to complete!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: _formKey,
                            autovalidate: true,
                            child: TextFormField(
                              validator: (val) {
                                if (val.indexOf(' ') >= 0 ||
                                    val.indexOf('-') >= 0) {
                                  return ("Can not Use space or -");
                                } else if (val.length <= 3) {
                                  return ("Username too short");
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  username1 = value.toLowerCase().trim();
                                });
                              },
                              onSaved: (val) {
                                username = val.toLowerCase().trim();
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: "Username", labelText: 'Username'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  child: Center(
                                    child: Text(
                                      'godzeela.com/$username1',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: RaisedButton(
                            onPressed: () {
                              try {
                                usersRef.doc(widget.userCredential.user.uid).set({
                                  'id': widget.userCredential.user.uid,
                                  'email': widget.userCredential.user.email,
                                  'username': username1,
                                  'photoURL': widget.userCredential.user.photoURL,
                                  'displayname': widget.userCredential.user.displayName,
                                  'profileURL' : "godzeela.com/$username1",
                                  'linkSharing': true,
                                  'timestamp': timestamp,
                                });
                                setState(() {
                                  currentUser = widget.userCredential.user;
                                  SnackBar snackBar = SnackBar(
                                    content: Text("Registration Complete!"),
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                  Timer(Duration(seconds: 2), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  });
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
