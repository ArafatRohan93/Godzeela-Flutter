import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:godzeela_flutter/components/login_signup_form.dart';
import 'package:godzeela_flutter/pages/complete_registration.dart';
import 'package:google_sign_in/google_sign_in.dart';

// final GoogleSignIn googleSignIn = GoogleSignIn();

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  bool rememberUser = false;
  String username;

  signUpUsingEmailPassword() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        print(userCredential.user);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteRegistration(
                      user: userCredential,
                    )));
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

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
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential != null) {
        print(userCredential.user);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteRegistration(
                      user: userCredential,
                    )));
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    try {
      // Once signed in, return the UserCredential
      final userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);

      if (userCredential != null) {
        print(userCredential.user);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteRegistration(
                      user: userCredential,
                    )));
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: LogInSignUp(
            fontName: 'PassionOne',
            logoPath: 'assets/images/godzilla_logo.svg',
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
            onPressedSubmit: () => signUpUsingEmailPassword(),
            onPressedFacebook: () => signInWithFacebook(),
            onPressedGoogle: () => signInWithGoogle(),
            rememberUser: rememberUser,
            title: 'Sign Up',
          ),
        ),
      ),
    );
  }
}
