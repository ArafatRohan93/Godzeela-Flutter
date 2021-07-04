import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:godzeela_flutter/components/drawer_icons_icons.dart';
import 'package:godzeela_flutter/pages/edit_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class BuildDrawer extends StatefulWidget {
  BuildDrawer({Key key}) : super(key: key);

  @override
  _BuildDrawerState createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {

  final double fontSize = 20;
 final double iconSize = 35;
 bool toogle = isBusiness ? businessProfile.linkSharing : userProfile.linkSharing;
 String title = isBusiness ? businessProfile.username : userProfile.username;

 launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
     SizedBox(height: 50.0),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
           title: Center(
               child: Text(
         title != null ? title : " ",
         style: TextStyle(
           fontSize: 25.0,
           fontFamily: textFont,
           fontWeight: FontWeight.bold,
         ),
       ))),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
         title: FlutterSwitch(
           onToggle: (value) {
             setState(() {
               toogle = value;
             });
             
             
             if(isBusiness){
               businessProfile.linkSharing = toogle;
               usersRef.doc(businessProfile.id).update({
                 "linkSharing" : toogle,
               });
               //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
             }
             else{
               userProfile.linkSharing = toogle;
               usersRef.doc(userProfile.id).update({
                 "linkSharing" : toogle,
               });
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
             }
           },
           value: toogle != null ? toogle : false,
           activeColor: Colors.black,
           activeText: "Profile On",
           inactiveText: "Profile Off",
           activeTextColor: Colors.white,
           inactiveTextColor: Colors.black,
           inactiveColor: Colors.white,
           inactiveToggleColor: Colors.black,
           inactiveSwitchBorder: Border.all(color: Colors.black, width: 3.0),
           activeSwitchBorder: Border.all(color: Colors.white, width: 3.0),
           width: 150.0,
           height: 50.0,
           valueFontSize: 15.0,
           toggleSize: 50.0,
           borderRadius: 30.0,
           padding: 8.0,
           showOnOff: true,
         ),
       ),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
         leading: Icon(
           DrawerIcons.home,
           size: iconSize,
         ),
         title: Text(
           'Home',
           style: TextStyle(
             fontFamily: textFont,
             fontSize: fontSize,
           ),
         ),
         onTap: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
         },
       ),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
         leading: Icon(
           DrawerIcons.user_edit,
           size: iconSize,
         ),
         title: Text(
           'Edit Profile',
           style: TextStyle(
             fontFamily: textFont,
             fontSize: fontSize,
           ),
         ),
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
         },
       ),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
         leading: Icon(
           DrawerIcons.wrench_outline,
           size: iconSize,
         ),
         title: Text(
           'Set up your device',
           style: TextStyle(
             fontFamily: textFont,
             fontSize: fontSize,
           ),
         ),
         onTap: () {
          AppSettings.openNFCSettings();
         },
       ),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
         leading: Icon(
           DrawerIcons.help,
           size: iconSize,
         ),
         title: Text(
           'How to use',
           style: TextStyle(
             fontFamily: textFont,
             fontSize: fontSize,
           ),
         ),
         onTap: () {
           launchURL( "https://www.youtube.com/channel/UCiPZGYibJhVASebsO-KtBNA");
         },
       ),
     ),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListTile(
         leading: Icon(
          DrawerIcons.logout,
           size: iconSize,
         ),
         title: Text(
           'Logout',
           style: TextStyle(
             fontFamily: textFont,
             fontSize: fontSize,
           ),
         ),
         onTap: () {
           currentUser = null;
           auth.signOut();
           googleSignIn.signOut();
           FacebookAuth.instance.logOut();
           userProfile = null;
           businessProfile = null;
           //setState(() {
           Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context) => LoginScreen()));
           //});
         },
       ),
     ),
      ],
    ),
  );
  }
}

// Drawer buildDrawer(BuildContext context) {
//  final double fontSize = 20;
//  final double iconSize = 35;
//  bool toogle = isBusiness ? businessProfile.linkSharing : userProfile.linkSharing;
//  String title = isBusiness ? businessProfile.username : userProfile.username;
//   return 
// }
