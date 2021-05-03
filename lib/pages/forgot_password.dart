import 'package:flutter/material.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;

  sendPasswordResetEmail(String email) async {
    try{
      await auth.sendPasswordResetEmail(email: email);
    Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error sending email: ${e.code}"),),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
      color: Colors.black,
      size: 40.0,
    ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Reset Password",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontFamily: textFont,
                fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_right,size: 30,),
                  ),
                  Text(
                    "Enter email to get the reset link.",
                    style: TextStyle(
                      fontFamily: textFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_right,size: 30,),
                  ),
                  Text(
                    "Follow the link from email.",
                    style: TextStyle(
                      fontFamily: textFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_right,size: 30,),
                  ),
                  Text(
                    "Enter new password and sign in!",
                    style: TextStyle(
                      fontFamily: textFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _email = value,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email', labelText: 'Email')),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(13)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () => sendPasswordResetEmail(_email),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Send Reset Link",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: textFont,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
