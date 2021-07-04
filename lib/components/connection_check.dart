import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

checkConnectivity(context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>NoInternet(),),);
      SnackBar snackBar = SnackBar(
        duration: Duration(days: 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("No Internet"),
            TextButton(
              onPressed: () {
                  checkConnectivity(context);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text("Retry",style: TextStyle(color: Colors.blue),),
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Back online")));
    }
  }

  connectionChangeListener(context){
  return Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
   if(result == ConnectivityResult.none){
     SnackBar snackBar = SnackBar(
        //duration: Duration(days: 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("No Internet"),
            TextButton(
              onPressed: () {
                  checkConnectivity(context);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text("Retry",style: TextStyle(color: Colors.blue),),
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }
   else{
     //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Back online")));
   }
  });
  }