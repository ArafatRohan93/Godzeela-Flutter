import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:godzeela_flutter/pages/edit_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    iconTheme: IconThemeData(
      color: Theme.of(context).primaryColor,
      size: 35.0,
    ),
    title: Center(
      child: SvgPicture.asset(
        'assets/images/godzilla_logo.svg',
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile())).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(),));
            });
          },
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.black,fontFamily: 'PassionOne',fontSize: 18),
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    ],
  );
}
