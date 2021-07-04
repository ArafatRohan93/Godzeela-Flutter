import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 40.0,
    ),
    title: Center(
      child: SvgPicture.asset(
        'assets/images/godzilla_logo.svg',
        width: 200,
        height: 70,
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.all(2.0),
        child: SizedBox(
          width: 10.0,
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //       right: 15.0, left: 8.0, top: 8.0, bottom: 8.0),
      //   child: Badge(
      //     // position: BadgePosition.topStart(),
      //     // badgeContent: Text('0',style: TextStyle(color: Colors.white),),
      //     child: Icon(
      //       Icons.notifications_active_outlined,
      //       color: Colors.black,
      //       size: 25.0,
      //     ),
      //     badgeColor: Colors.red,
      //   ),
      // ),
    ],
  );
}
