import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/login_screen.dart';

Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: 150.0,
              child: SvgPicture.asset(
                'assets/images/godzilla_logo.svg',
                //height: orientation == Orientation.portrait ?  300.0 : 200.0 ,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.link),
            title: Text('Profile Link'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Add Links'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.remove_circle_outline),
            title: Text('Logout'),
            onTap: () {
              // Update the state of the app.
              // ...
              currentUser = null;
              auth.signOut();
              googleSignIn.signOut();
              FacebookAuth.instance.logOut();
              //setState(() {
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
              //});
            },
          ),
        ],
      ),
    );
}