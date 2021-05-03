import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:godzeela_flutter/components/login_signup_form.dart';
import 'package:godzeela_flutter/pages/complete_registration.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  bool rememberUser = false;
  String errorMessage;

  loginWithEmailPassword() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
            print(error);
        setState(() {
          errorMessage = error.code;
        });
      });
      if (userCredential == null) {
        setState(() {
          errorMessage = "Invalid email or password!";
        });
      } else if (userCredential != null) {
        print(userCredential.user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      setState(() {
        currentUser = userCredential.user;
        showSpinner = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        errorMessage = e.code;
      });
      print(e);
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      setState(() {
        errorMessage = e.code;
      });
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      final userCredential =
          await _auth.signInWithCredential(credential).catchError((error) {
        setState(() {
          errorMessage = error.code;
        });
      });

      var data = await usersRef.doc(userCredential.user.uid).get();
      if (!data.exists) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteRegistration(
                      userCredential: userCredential,
                    )));
      } else if (data != null) {
        currentUser = userCredential.user;
        print(userCredential.user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.code;
      });
      print(e);
    }
  }

  Future<Null> signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance
        .login()
        .catchError((onError) => print(onError));

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    try {
      // Once signed in, return the UserCredential

      final userCredential = await _auth
          .signInWithCredential(facebookAuthCredential)
          .catchError((error) {
        setState(() {
          errorMessage = error.code;
        });
      });

      var data = await usersRef.doc(userCredential.user.uid).get();

      if (!data.exists) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteRegistration(
                      userCredential: userCredential,
                    )));
      } else if (data != null) {
        currentUser = userCredential.user;
        print(userCredential.user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.code;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
          child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: LogInSignUp(
              needConfirm: false,
              errorMessage: errorMessage,
              logoPath: "assets/images/godzilla_logo.svg",
              fontName: textFont,
              title: "Log In",
              rememberUser: rememberUser,
              onChangedCheckbox: (value) {
                setState(() {
                  rememberUser = value;
                });
              },
              onChangedEmailField: (value) {
                email = value;
              },
              onChangedPasswordField: (value) {
                password = value;
              },
              onPressedFacebook: () => signInWithFacebook(),
              onPressedGoogle: () => signInWithGoogle(),
              onPressedSubmit: () => loginWithEmailPassword(),
            ),
          ),
        ),
      ),
    );
  }
}
