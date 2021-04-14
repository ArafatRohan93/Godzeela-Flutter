import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:godzeela_flutter/components/appBar.dart';
import 'package:godzeela_flutter/components/drawer.dart';
import 'package:godzeela_flutter/components/progress.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/login_screen.dart';
import 'package:godzeela_flutter/pages/user_home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final StorageReference storageRef = FirebaseStorage.instance.ref();
final DateTime timestamp = DateTime.now();
User currentUser;
UserProfile userProfile = UserProfile(username: " ",linkSharing: true);
final FacebookLogin facebookSignIn = new FacebookLogin();
final String textFont = 'PassionOne';
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController;
  int pageIndex = 0;
  bool sharingStatus = true;
  bool isAuth = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PaintingBinding.instance.imageCache.clear();
    getCurrentUserData();
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
        userProfile = UserProfile.fromDocument(doc);
        print(userProfile.photoURL);
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  onTap(int pageIndex) {
    print(auth);
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget buildAuthScreen() {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: buildAppBar(context),
      body: PageView(
        children: <Widget>[
          UserHome(
            userProfile: userProfile,
          ) 
          // ActivityFeed(),
          // Upload(currentUser : currentUser),
          // Search(),
          // Profile(profileId: currentUser?.id,),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }

  onPageChanged(int pageIndex) {
    setState(() {
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
