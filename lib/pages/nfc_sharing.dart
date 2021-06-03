import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:godzeela_flutter/components/nfc_icon_icons.dart';
import 'package:godzeela_flutter/components/q_r_icon_icons.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/qr_view.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NfcSharing extends StatefulWidget {
  NfcSharing({Key key}) : super(key: key);

  @override
  _NfcSharingState createState() => _NfcSharingState();
}

class _NfcSharingState extends State<NfcSharing> {
  // bool _supportsNFC = false;
  // bool _reading = false;
  // StreamSubscription<NDEFMessage> _stream;

  // @override
  // void initState() {
  //   super.initState();
  //   // Check if the device supports NFC reading
  //   NFC.isNDEFSupported.then((bool isSupported) {
  //     setState(() {
  //       _supportsNFC = isSupported;
  //     });
  //   });
  // }


  String data = isBusiness ? businessProfile.profileURL : userProfile.profileURL;

  copyToClipboard(String data) {
    Clipboard.setData(new ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text("Copied to Clipboard"),
      ),
    );
  }

  TextEditingController writerController = TextEditingController();
  NFCAvailability available;

  checkNFCAvailability() async {
    available = await FlutterNfcReader.checkNFCAvailability();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkNFCAvailability();
    });

    writerController.text = 'Flutter NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      print(onData.content);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    writerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (available == NFCAvailability.not_supported || available == NFCAvailability.disabled) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(alignment: Alignment.bottomRight, children: [
                  Icon(
                    Icons.nfc,
                    size: 100.0,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.error,
                    size: 30.0,
                    color: Colors.yellow,
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Oops!",
                  style: TextStyle(
                    fontFamily: textFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 35.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Device does not support NFC or NFC is disabled!\nEnable nfc or Share using QR code instead!",
                  style: TextStyle(
                    fontFamily: textFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
              ),

              // ignore: missing_required_param
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QRView()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          QRIcon.qr_code,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                      Text(
                        "Open QR code",
                        style: TextStyle(
                          fontFamily: textFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(5)),
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
                          color: Colors.black,
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
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(5)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.black)))),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text("Write"),
                onPressed: () {
                  FlutterNfcReader.write(" ", data != null ? data : "Nfc data")
                      .then((value) {
                    print(value.content);
                  });
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(5)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.black)))),
              ),
            ),
          ],
        ),
      ),
    );
    // return Column(
    //   children: <Widget>[
    //     Text(available.toString()),
    //     TextField(
    //       controller: writerController,
    //     ),
    //     RaisedButton(
    //       onPressed: () {
    //         FlutterNfcReader.read(instruction: "It's reading");
    //       },
    //       child: Text("Read"),
    //     ),
    //     RaisedButton(
    //       onPressed: () {
    //         FlutterNfcReader.write(" ", writerController.text).then((value) {
    //           print(value.content);
    //         });
    //       },
    //       child: Text("Write"),
    //     )
    //   ],
    // );
  }
}

// @override
// Widget build(BuildContext context) {
//   if (!_supportsNFC) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Stack(
//                 alignment: Alignment.bottomRight,
//                 children: [
//                 Icon(
//                   Icons.nfc,
//                   size: 100.0,
//                   color: Colors.red,
//                 ),
//                Icon(Icons.error,size: 30.0,color: Colors.yellow,)
//               ]),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 "Oops!",
//                 style: TextStyle(
//                   fontFamily: textFont,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 35.0,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "Device does not support nfc!\nShare using QR code instead!",
//                 style: TextStyle(
//                   fontFamily: textFont,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ),

//             // ignore: missing_required_param
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => QRView()));
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(
//                         QRIcon.qr_code,
//                         color: Colors.white,
//                         size: 35.0,
//                       ),
//                     ),
//                     Text(
//                       "Open QR code",
//                       style: TextStyle(
//                         fontFamily: textFont,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.all(5)),
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.black),
//                     foregroundColor:
//                         MaterialStateProperty.all<Color>(Colors.white),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             side: BorderSide(color: Colors.black)))),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () => copyToClipboard(userProfile.profileURL),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(
//                         Icons.link,
//                         color: Colors.black,
//                         size: 35.0,
//                       ),
//                     ),
//                     Text(
//                       "Copy Link",
//                       style: TextStyle(
//                         fontFamily: textFont,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsets>(
//                         EdgeInsets.all(5)),
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.white),
//                     foregroundColor:
//                         MaterialStateProperty.all<Color>(Colors.black),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             side: BorderSide(color: Colors.black)))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   return Scaffold(
//     body: Center(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               child: Text(_reading ? "Stop reading" : "Start reading"),
//               onPressed: () {
//                 if (_reading) {
//                   _stream?.cancel();
//                   setState(() {
//                     _reading = false;
//                   });
//                 } else {
//                   setState(() {
//                     _reading = true;
//                     // Start reading using NFC.readNDEF()
//                     _stream = NFC
//                         .readNDEF(
//                       once: true,
//                       throwOnUserCancel: false,
//                     )
//                         .listen((NDEFMessage message) {
//                       print("read NDEF message: ${message.payload}");
//                     }, onError: (e) {
//                       // Check error handling guide below
//                     });
//                   });
//                 }
//               },
//               style: ButtonStyle(
//                   padding: MaterialStateProperty.all<EdgeInsets>(
//                       EdgeInsets.all(5)),
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Colors.white),
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.black),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           side: BorderSide(color: Colors.black)))),
//             ),
//           ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                   child: Text("Write"),
//                   onPressed: () {
//                     Stream<NDEFMessage> stream = NFC.readNDEF();

// stream.listen((NDEFMessage message) {
//     NDEFMessage newMessage = NDEFMessage.withRecords(
//         NDEFRecord.mime("text/plain", userProfile.profileURL),
//     );
//     message.tag.write(newMessage);
// });
//                   },
//                   style:ButtonStyle(
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                                 EdgeInsets.all(5)),
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                             foregroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.black),
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     side: BorderSide(color: Colors.black)))),
//                       ),
//             ),
//         ],
//       ),
//     ),
//   );
// }
// }
