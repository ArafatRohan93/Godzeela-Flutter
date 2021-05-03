import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:ui';

class QRView extends StatefulWidget {
  QRView({Key key}) : super(key: key);

  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  GlobalKey globalKey = new GlobalKey();

  copyToClipboard(String data) {
    Clipboard.setData(new ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text("Copied to Clipboard"),
      ),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  // embeddedImage:
                  //     CachedNetworkImageProvider(userProfile.photoURL),
                  version: QrVersions.auto,
                  data: "${userProfile.profileURL}",
                  size: 0.3 * bodyHeight,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Uh oh! Something went wrong...",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(
                userProfile.profileURL,
               style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontFamily: textFont,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => copyToClipboard(userProfile.profileURL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.link,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                  Text(
                    "Copy Link",
                    style: TextStyle(
                      fontFamily: textFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.black)))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: _contentWidget(),
      )),
    );
  }
}
