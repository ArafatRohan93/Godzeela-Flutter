import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:godzeela_flutter/components/appBar.dart';
import 'package:godzeela_flutter/components/connection_check.dart';
import 'package:godzeela_flutter/components/drawer.dart';
import 'package:godzeela_flutter/components/drawer_icons_icons.dart';
import 'package:godzeela_flutter/components/nfc_icon_icons.dart';
import 'package:godzeela_flutter/components/q_r_icon_icons.dart';
import 'package:godzeela_flutter/models/business_profile.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/business_home.dart';
import 'package:godzeela_flutter/pages/login_screen.dart';
import 'package:godzeela_flutter/pages/nfc_scan.dart';
import 'package:godzeela_flutter/pages/qr_view.dart';
import 'package:godzeela_flutter/pages/user_home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final StorageReference storageRef = FirebaseStorage.instance.ref();
final DateTime timestamp = DateTime.now();
User currentUser;
UserProfile userProfile = UserProfile(username: " ", linkSharing: true);
BusinessProfile businessProfile =
    BusinessProfile(username: " ", linkSharing: true);
bool isBusiness = false;
final FacebookLogin facebookSignIn = new FacebookLogin();

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController = new PageController();
  int pageIndex = 0;
  bool sharingStatus = true;
  bool isAuth = false;
  bool isLoading = false;
  var subscription;
  @override
  void initState() {
    super.initState();
    PaintingBinding.instance.imageCache.clear();
    checkConnectivity(context);
    //subscription = connectionChangeListener(context);
    getCurrentUserData();
  }

  @override
  void dispose() { 
    //subscription.cancel();
    super.dispose();
  }

  

  getCurrentUserData() async {
    final user = await _auth.currentUser;
    if (user != null) {
      setState(() {
        isAuth = true;
        currentUser = user;
        isLoading = true;
      });
      try {
        DocumentSnapshot doc = await usersRef.doc(user.uid).get();
        isBusiness = doc.data()['accountType'] == 'Business';
        if (isBusiness) {
          businessProfile = BusinessProfile.fromDocument(doc);
        } else {
          userProfile = UserProfile.fromDocument(doc);
          //print(userProfile.photoURL);
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  onTap(int pageIndex) {
    // print(pageIndex);
    //print(auth);
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget buildAuthScreen() {
    return Scaffold(
      key: _scaffoldKey,
      drawer: BuildDrawer(),
      appBar: buildAppBar(context),
      body: PageView(
        children: <Widget>[
          isBusiness
              ? BusinessHome(
                  businessProfile: businessProfile,
                )
              : UserHome(
                  userProfile: userProfile,
                ),
          QRView(),
          NfcScan(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black,
        selectedIndex: pageIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: onTap,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(
              DrawerIcons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Colors.white70,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              QRIcon.qr_code,
              color: Colors.white,
            ),
            title: Text(
              'QR Code',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Colors.white70,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              NfcIcon.nfc,
              color: Colors.white,
            ),
            title: Text(
              'NFC Sharing',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Colors.white70,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  onPageChanged(int pageIndex) {
    setState(() {
      // print(pageIndex);
      this.pageIndex = pageIndex;
    });
  }

  buildUnAuthScreen() {
    return LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: isAuth ? buildAuthScreen() : buildUnAuthScreen(),
    );
  }
}
