import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:godzeela_flutter/components/google_icon.dart';
import 'package:godzeela_flutter/components/social_icons.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/login_screen.dart';
import 'package:godzeela_flutter/pages/signup_screen.dart';

class LogInSignUp extends StatelessWidget {
  const LogInSignUp({
    @required this.rememberUser,
    @required this.title,
    @required this.onChangedEmailField,
    @required this.onChangedPasswordField,
    @required this.onChangedCheckbox,
    @required this.onPressedSubmit,
    @required this.onPressedGoogle,
    @required this.onPressedFacebook,
    @required this.fontName,
    @required this.logoPath,
  });

  final String title;
  final bool rememberUser;
  final Function onChangedEmailField;
  final Function onChangedPasswordField;
  final Function onChangedCheckbox;
  final Function onPressedSubmit;
  final Function onPressedGoogle;
  final Function onPressedFacebook;
  final String fontName;
  final String logoPath;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        height: 200.0,
        child: SvgPicture.asset(
          logoPath,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    '$title',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontFamily: fontName,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: onChangedEmailField,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Email', labelText: 'Email')),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: TextField(
                    obscureText: true,
                    onChanged: onChangedPasswordField,
                    //  (value) {
                    //   password = value;
                    // },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Password', labelText: 'Password')),
              ),
              SizedBox(
                height: 18.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: rememberUser,
                      onChanged: onChangedCheckbox,
                      // (value) {
                      //   setState(() {
                      //     rememberUser = value;
                      //   });
                      // },
                    ),
                    Text('Remember me!'),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: FlatButton(
                        color: Colors.black,
                        child: Text(
                          '$title',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontName,
                          ),
                        ),
                        onPressed: onPressedSubmit,
                        // () => loginWithEmailPassword(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: FlatButton(
                    onPressed: onPressedGoogle,
                    // () => signInWithGoogle(),
                    color: Colors.lightBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            GoogleIcon.google,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: fontName,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: FlatButton(
                    onPressed: onPressedFacebook,
                    //()  => signInWithFacebook(),
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            SocialIcons.facebook,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        Text(
                          'Sign in with Facebook',
                          style: TextStyle(
                              fontFamily: fontName,
                              fontSize: 20.0,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title == 'Log In'
                          ? "Don't have an account?"
                          : "Already have an account?",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: fontName,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        title == 'Log In'
                                  ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SignupScreen())) :Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  LoginScreen()));
                        
                      },
                      child: Text(
                        title == 'Log In' ? 'Sign Up' : 'Log In',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue,
                          fontFamily: fontName,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
