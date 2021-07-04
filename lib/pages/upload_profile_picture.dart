import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:godzeela_flutter/components/connection_check.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/models/business_profile.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';

class UploadProfilePicture extends StatefulWidget {
  UploadProfilePicture();

  @override
  _UploadProfilePictureState createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  bool isUploading = false;
  File _image;
  final picker = ImagePicker();
  FocusNode focusSelectImage;
  FocusNode focusUploadImage;
  var subscription;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        //print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //checkConnectivity(context);
    //subscription = connectionChangeListener(context);

    focusSelectImage = FocusNode();
    focusUploadImage = FocusNode();
  }


  @override
  void dispose() {
    subscription.cancel();
    focusUploadImage.dispose();
    focusSelectImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isUploading,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 40.0,
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            title: Text(
              "Change Avatar",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontFamily: textFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: "PickImageBtn",
                    autofocus: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                    child: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
                _image == null
                    ? SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: "UploadImageBtn",
                          autofocus: true,
                          backgroundColor: Theme.of(context).primaryColor,
                          tooltip: 'Upload',
                          child: Icon(Icons.file_upload),
                          onPressed: isUploading ? null : () => handleSubmit(),
                        ),
                      ),
              ],
            ),
          )),
    );
  }

  handleSubmit() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      SnackBar snackBar = SnackBar(
        //duration: Duration(days: 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("No Internet!"),
            TextButton(
              onPressed: () {
                checkConnectivity(context);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      setState(() {
        isUploading = true;
      });
      File compressedFile = await compressImage();
      String mediaUrl = await uploadImage(compressedFile);

      updateProfilePhoto(mediaUrl);
      if (isBusiness) {
        try {
          DocumentSnapshot doc = await usersRef.doc(businessProfile.id).get();
          businessProfile = BusinessProfile.fromDocument(doc);
        } catch (e) {
          setState(() {
        isUploading = false;
      });
          print(e);
        }
        //print(businessProfile.photoURL);
        setState(() {
          isUploading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      } else {
        try {
          DocumentSnapshot doc = await usersRef.doc(userProfile.id).get();
          userProfile = UserProfile.fromDocument(doc);
        } catch (e) {
          setState(() {
        isUploading = false;
      });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Problem uploading file!"),));
          print(e);
        }
        // print(userProfile.photoURL);
        setState(() {
          isUploading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      }
    }
  }

  updateProfilePhoto(String url) {
    if (isBusiness) {
      try {
        usersRef.doc(businessProfile.id).update({
          "photoURL": url,
        });
      } catch (e) {
        print("Error updating photoURL : $e");
      }
    } else {
      try {
        usersRef.doc(userProfile.id).update({
          "photoURL": url,
        });
      } catch (e) {
        print("Error updating photoURL : $e");
      }
    }
  }

  compressImage() async {
    if(isBusiness){
       final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_${businessProfile.id}.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    return compressedImageFile;
    }
    else{
      final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_${userProfile.id}.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    return compressedImageFile;
    }
    
  }

  Future<String> uploadImage(imageFile) async {
     if(isBusiness){
       StorageUploadTask uploadTask =
        storageRef.child("Image_${businessProfile.id}.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
     }
     else{
       StorageUploadTask uploadTask =
        storageRef.child("Image_${userProfile.id}.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
     }
    
  }
}
