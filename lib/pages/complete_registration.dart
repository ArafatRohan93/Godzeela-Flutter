import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:godzeela_flutter/components/connection_check.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';

class CompleteRegistration extends StatefulWidget {
  final UserCredential userCredential;
  CompleteRegistration({this.userCredential});

  @override
  _CompleteRegistrationState createState() => _CompleteRegistrationState();
}

enum AccountType { personal, business }

class _CompleteRegistrationState extends State<CompleteRegistration> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;
  String username1 = '';
  AccountType accountType = AccountType.personal;
  List<String> acc = ["Personal", "Business"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Container(
                  height: 100.0,
                  child: SvgPicture.asset(
                    'assets/images/godzilla_logo.svg',
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.black,
                      //   width: 2.0,
                      // ),
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
                            'Select account type:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Radio(
                              value: AccountType.personal,
                              groupValue: accountType,
                              onChanged: (AccountType value) {
                                setState(() {
                                  accountType = value;
                                  //print(accountType.toString());
                                });
                              },
                            ),
                            title: Text("Personal"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Radio(
                              value: AccountType.business,
                              groupValue: accountType,
                              onChanged: (AccountType value) {
                                setState(() {
                                  accountType = value;
                                });
                              },
                            ),
                            title: Text("Business"),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
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
                            autovalidateMode: AutovalidateMode.always,
                            child: TextFormField(
                              validator: (val) {
                                if (val.indexOf(' ') >= 0 ||
                                    val.indexOf('-') >= 0) {
                                  return ("Can not Use space or -");
                                } else if (val.length <= 3) {
                                  return ("Username too short");
                                }
                                else if (val.length >= 12) {
                                  return ("Username too long");
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
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                SnackBar snackBar = SnackBar(
                                  duration: Duration(days: 1),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("No Internet!"),
                                      TextButton(
                                        onPressed: () {
                                          checkConnectivity(context);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        },
                                        child: Text(
                                          "Retry",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                if (username1.length >= 3) {
                                  try {
                                    usersRef
                                        .doc(widget.userCredential.user.uid)
                                        .set({
                                      'id': widget.userCredential.user.uid,
                                      'email': widget.userCredential.user.email,
                                      'username': username1,
                                      'photoURL':
                                          widget.userCredential.user.photoURL,
                                      'displayname': widget
                                          .userCredential.user.displayName,
                                      'linkSharing': true,
                                      'timestamp': timestamp,
                                      'accountType': acc[accountType.index],
                                      'profileURL':
                                          "http://www.godzeela.link/profile.php?id=${widget.userCredential.user.uid}",
                                    });
                                    setState(() {
                                      currentUser = widget.userCredential.user;
                                      SnackBar snackBar = SnackBar(
                                        content: Text("Registration Complete!"),
                                      );
                                      ScaffoldMessenger.of(context)
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
                                } else {
                                  SnackBar snackBar = SnackBar(
                                    content: Text("Username is not valid!"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  // Timer(Duration(seconds: 2), () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => Home()));
                                  // });

                                }
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
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(13)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side:
                                            BorderSide(color: Colors.black)))),
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
