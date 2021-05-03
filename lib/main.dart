import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:page_transition/page_transition.dart';

import 'constants.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: textFont,
      ),
      home: AnimatedSplashScreen(
          duration: 1000,
          splash: SvgPicture.asset("assets/images/godzilla_logo_inverse.svg",),
          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.black,
        )
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'GODZEELA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        accentColor: Colors.grey[700],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Home(),
    );
  }
}
