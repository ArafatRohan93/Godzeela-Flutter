import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:godzeela_flutter/components/google_icon.dart';
import 'package:godzeela_flutter/components/social_icons.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/forgot_password.dart';
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
    this.onChangedConfirmPasswordField,
    @required this.needConfirm,
    @required this.errorMessage,
  });

  final String title;
  final bool rememberUser;
  final Function onChangedEmailField;
  final Function onChangedPasswordField;
  final Function onChangedConfirmPasswordField;
  final Function onChangedCheckbox;
  final Function onPressedSubmit;
  final Function onPressedGoogle;
  final Function onPressedFacebook;
  final String fontName;
  final String logoPath;
  final bool needConfirm;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        height: 100.0,
        child: SvgPicture.asset(
          logoPath,
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(
        //       15,
        //     ),
        //   ),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.3),
        //       blurRadius: 5,
        //       spreadRadius: 5,
        //       offset: Offset(0, 3),
        //     ),
        //   ],
        // ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '$title',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: fontName,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: onPressedGoogle,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black54,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/images/google_g.svg",
                              height: 20.0,
                              width: 20.0,
                            ),
                          ),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: fontName,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: onPressedFacebook,
                    //()  => signInWithFacebook(),
                    // color: Colors.blueAccent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Or",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
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
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Password', labelText: 'Password')),
              ),
              needConfirm
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: TextField(
                              obscureText: true,
                              onChanged: onChangedConfirmPasswordField,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password')),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              title == 'Log In'
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text(
                              "Forgot Password",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                                fontFamily: fontName,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 10.0,
                    ),
              errorMessage != null
                  ? SizedBox(
                      height: 15.0,
                      child: Text(
                        "$errorMessage",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: rememberUser,
                      onChanged: onChangedCheckbox,
                    ),
                    Text('Remember me!'),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            '$title',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontFamily: fontName,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: onPressedSubmit,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title == 'Log In'
                      ? "Don't have an account?"
                      : "Already have an account?",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: fontName,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    title == 'Log In'
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black54,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            title == 'Log In' ? 'Sign Up' : 'Log In ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontFamily: fontName,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    ]);
  }
}
