import 'dart:typed_data';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:godzeela_flutter/components/drawer_icons_icons.dart';
import 'package:godzeela_flutter/components/q_r_icon_icons.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/nfc_popup.dart';
import 'package:godzeela_flutter/pages/qr_view.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

class _NfcScanState extends State<NfcScan> with WidgetsBindingObserver {
  String outPut = "Tap on Power";
  String urlData =
      isBusiness ? businessProfile.profileURL : userProfile.profileURL;
  ValueNotifier<dynamic> result = ValueNotifier(null);

  DateTime _startTime;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _startTime = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        // _reportData(DateTime.now().difference(_startTime));
        return;
      case AppLifecycleState.resumed:
        _startTime = DateTime.now();
        setState(() {});
        return;
      default:
        return;
    }
  }

  copyToClipboard(String data) {
    Clipboard.setData(new ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text("Copied to Clipboard"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => ss.data != true
              ? buildNfcUnavailableScreen(context)
              : buildNfcAvailableScreen(context),
        ),
      ),
    );
  }

  Center buildNfcAvailableScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/power.svg',
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.height * .2,
                      ),
                    ),
                    onPressed: () {
                      _ndefWrite();
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FittedBox(
              child: Text(
                outPut,
                style: TextStyle(
                  fontFamily: textFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center buildNfcUnavailableScreen(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(alignment: Alignment.bottomRight, children: [
                Icon(
                  Icons.nfc,
                  size: 100.0,
                  color: Colors.grey,
                ),
                // Icon(
                //   Icons.not_interested_rounded,
                //   size: 30.0,
                //   color: Colors.grey,
                // ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => AppSettings.openNFCSettings(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        DrawerIcons.wrench_outline,
                        color: Colors.black,
                        size: 25.0,
                      ),
                    ),
                    Text(
                      "Open Settings",
                      style: TextStyle(
                        fontFamily: textFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(8)),
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () =>
                          copyToClipboard(userProfile.profileURL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.link,
                              color: Colors.black,
                              size: 25.0,
                            ),
                          ),
                          Text(
                            "Copy Link",
                            style: TextStyle(
                              fontFamily: textFont,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(8)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.black)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRView()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              QRIcon.qr_code,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                          Text(
                            "Open QR code",
                            style: TextStyle(
                              fontFamily: textFont,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(8)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.black)))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tagRead() {
    //NfcManager.instance.stopSession();
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void _ndefWrite() {
    setState(() {
      outPut = "Waiting for Approaching a Tag ...";
    });
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        showModalBottomSheet(
          context: context,
          builder: (context) => NFCPopUp(
            title: "Failed",
            details: 'Tag is not ndef writable',
          ),
        );
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createUri(Uri.parse(urlData)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Write Successfull!!';
        showModalBottomSheet(
          context: context,
          builder: (context) => NFCPopUp(
            title: "Successful",
            details: "Write on tag successful",
          ),
        );
        NfcManager.instance.stopSession();
        setState(() {
          outPut = "Tap on Power";
        });
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        showModalBottomSheet(
          context: context,
          builder: (context) => NFCPopUp(
            title: "Failed",
            details: result.value.toString(),
          ),
        );
        return;
      }
    });
  }
}
