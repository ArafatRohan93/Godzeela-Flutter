import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:godzeela_flutter/components/progress.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UploadProfilePicture extends StatefulWidget {
  UploadProfilePicture();
  // UploadProfilePicture({@required this.file});
  // final File file;

  @override
  _UploadProfilePictureState createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  bool isUploading = false;
  File _image;
  final picker = ImagePicker();
  FocusNode focusSelectImage;
  FocusNode focusUploadImage;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    focusSelectImage = FocusNode();
    focusUploadImage = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1.0,
            title: Text("Change Avatar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontSize: 30.0, fontFamily: textFont)),
          ),
          body: Center(
            child:
                _image == null ? Text('No image selected.') : Image.file(_image),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: "PickImageBtn",
                    autofocus: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo,),
                  ),
                ),
               _image == null
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                      FloatingActionButton(
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
  // body: SingleChildScrollView(
  //   child: Column(
  //     children: [
  //       isUploading ? linearProgress() : Text(""),
  //       Expanded(
  //         child: Center(
  //           child: Image.file(file),
  //         ),
  //       ),
  //       Center(
  //         child: Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: RaisedButton(
  //             child: Text(
  //               "Upload",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             color: Colors.black,
  //             onPressed: isUploading ? null : () => handleSubmit(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // ),
  //   );
  // }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    File compressedFile = await compressImage();
    String mediaUrl = await uploadImage(compressedFile);

    updateProfilePhoto(mediaUrl);
    try {
      DocumentSnapshot doc = await usersRef.doc(currentUser.uid).get();
      userProfile = UserProfile.fromDocument(doc);
    } catch (e) {
      print(e);
    }
    print(userProfile.photoURL);
    setState(() {
      isUploading = false;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  updateProfilePhoto(String url) {
    try {
      usersRef.doc(userProfile.id).update({
        "photoURL": url,
      });
    } catch (e) {
      print("Error updating photoURL : $e");
    }
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_${userProfile.id}.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    return compressedImageFile;
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child("Image_${userProfile.id}.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }
}