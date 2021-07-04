import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.wifi_off,size: 50.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No internet"),
            ),
          ],
          ),
        ),
      ),
    );
  }
}