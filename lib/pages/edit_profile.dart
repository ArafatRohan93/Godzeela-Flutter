import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:godzeela_flutter/components/social_item_tile.dart';
import 'package:godzeela_flutter/models/business_profile.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/upload_profile_picture.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File file;
  bool sharingStatus =
      isBusiness ? businessProfile.linkSharing : userProfile.linkSharing;
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay pickedTime;
  String openingTime = isBusiness ? businessProfile.openingTime : "";
  FocusNode bioFocusNode,
      fbFocusNode,
      instaFocusNode,
      twitterFocusNode,
      linkedinFocusNode,
      pinterestFocusNode,
      youtubeFocusNode,
      snapchatFocusNode,
      twitchFocusNode,
      phoneFocus,
      pWebFocus,
      fullNameFocus,
      pEmailFocus,
      wEmailFocus,
      wPlaceFocus,
      tiktokFocus,
      openingTimeFocus;
  bool isLoading = false;
  String bio = isBusiness ? businessProfile.bio : userProfile.bio;
  String facebookLink =
      isBusiness ? businessProfile.facebookLink : userProfile.facebookLink;
  String twitterLink =
      isBusiness ? businessProfile.twitterLink : userProfile.twitterLink;
  String snapchatLink =
      isBusiness ? businessProfile.snapchatLink : userProfile.snapchatLink;
  String instagramLink =
      isBusiness ? businessProfile.instagramLink : userProfile.instagramLink;
  String pinterestLink =
      isBusiness ? businessProfile.pinterestLink : userProfile.pinterestLink;
  String twitchLink =
      isBusiness ? businessProfile.twitchLink : userProfile.twitchLink;
  String youtubeLink =
      isBusiness ? businessProfile.youtubeLink : userProfile.youtubeLink;
  String linkedinLink =
      isBusiness ? businessProfile.linkedinLink : userProfile.linkedinLink;
  String phoneNo = isBusiness ? businessProfile.phoneNo : userProfile.phoneNo;
  String workplace =
      isBusiness ? businessProfile.address : userProfile.workplace;
  String personalWebsiteLink = isBusiness
      ? businessProfile.businessWebsiteLink
      : userProfile.personalWebsiteLink;
  String fullName =
      isBusiness ? businessProfile.businessName : userProfile.fullName;
  String personalEmail = userProfile.personalEmail;
  String workEmail =
      isBusiness ? businessProfile.businessEmail : userProfile.workEmail;
  String tiktokLink =
      isBusiness ? businessProfile.tiktokLink : userProfile.tiktokLink;
  String photoURL =
      isBusiness ? businessProfile.photoURL : userProfile.photoURL;

  @override
  void initState() {
    super.initState();

    bioFocusNode = FocusNode();
    fbFocusNode = FocusNode();
    instaFocusNode = FocusNode();
    twitterFocusNode = FocusNode();
    linkedinFocusNode = FocusNode();
    pinterestFocusNode = FocusNode();
    youtubeFocusNode = FocusNode();
    snapchatFocusNode = FocusNode();
    twitchFocusNode = FocusNode();
    phoneFocus = FocusNode();
    pWebFocus = FocusNode();
    fullNameFocus = FocusNode();
    pEmailFocus = FocusNode();
    wEmailFocus = FocusNode();
    wPlaceFocus = FocusNode();
    tiktokFocus = FocusNode();
    openingTimeFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    bioFocusNode.dispose();
    fbFocusNode.dispose();
    instaFocusNode.dispose();
    twitterFocusNode.dispose();
    linkedinFocusNode.dispose();
    pinterestFocusNode.dispose();
    youtubeFocusNode.dispose();
    snapchatFocusNode.dispose();
    twitchFocusNode.dispose();
    phoneFocus.dispose();
    pWebFocus.dispose();
    fullNameFocus.dispose();
    pEmailFocus.dispose();
    wEmailFocus.dispose();
    wPlaceFocus.dispose();
    tiktokFocus.dispose();
    openingTimeFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 40.0,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text("Edit Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontFamily: textFont,
                    fontWeight: FontWeight.bold)),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height * 1.2
                    : MediaQuery.of(context).size.height * 1.6,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    width: 6.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        backgroundImage: photoURL != null
                                            ? CachedNetworkImageProvider(
                                                photoURL)
                                            : AssetImage(
                                                'assets/images/dummyProfile.png'),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: IconButton(
                                            onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UploadProfilePicture())),
                                            icon: Icon(
                                              Icons.edit,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Text(
                                  "Bio",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: textFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                title: TextField(
                                  focusNode: bioFocusNode,
                                  controller: TextEditingController()
                                    ..text = bio,
                                  onChanged: (value) => bio = value,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Edit Bio"),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                    size: 15.0,
                                  ),
                                  onPressed: () => bioFocusNode.requestFocus(),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Sharing",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: textFont,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "Allow others to see you online.",
                                                  style:
                                                      TextStyle(fontSize: 13.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: FlutterSwitch(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                value: sharingStatus,
                                                onToggle: (value) {
                                                  setState(() {
                                                    sharingStatus = value;
                                                    print(value);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: AppBar(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          bottom: TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            labelStyle: TextStyle(
                              fontFamily: textFont,
                              fontSize: 20.0,
                            ),
                            unselectedLabelColor: Theme.of(context).accentColor,
                            indicatorColor: Theme.of(context).primaryColor,
                            tabs: [
                              Tab(
                                // icon: Icon(Icons.directions_bike),
                                text: isBusiness
                                    ? "Business Info"
                                    : "Personal Info",
                              ),
                              Tab(
                                // icon: Icon(Icons.directions_car,
                                text: "Social Info",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // first tab bar view widget
                          SingleChildScrollView(
                            child: isBusiness
                                ? buildEditBusinessInfo()
                                : buildEditPersonalInfo(),
                          ),
                          // second tab bar viiew widget
                          SingleChildScrollView(
                            child: buildEditSocialMediaInfo(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SvgPicture.asset(
                      "assets/images/godzilla_logo.svg",
                      width: 150.0,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.check),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              if (isBusiness) {
                try {
                  usersRef.doc(businessProfile.id).update({
                    "bio": bio,
                    "linkSharing": sharingStatus,
                    "facebookLink": facebookLink,
                    "twitterLink": twitterLink,
                    "snapchatLink": snapchatLink,
                    "instagramLink": instagramLink,
                    "pinterestLink": pinterestLink,
                    "twitchLink": twitchLink,
                    "youtubeLink": youtubeLink,
                    "linkedinLink": linkedinLink,
                    "phoneNo": phoneNo,
                    "address": workplace,
                    "businessName": fullName,
                    "businessEmail": workEmail,
                    "businessWebsiteLink":personalWebsiteLink,
                    "openingTime": openingTime,
                    "tiktokLink": tiktokLink,
                    "profileURL":
                        "https://godzeela-flutter.web.app/#/profile/${businessProfile.id}",
                  });

                  try {
                    DocumentSnapshot doc =
                        await usersRef.doc(currentUser.uid).get();
                    businessProfile = BusinessProfile.fromDocument(doc);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    isLoading = false;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                } catch (e) {
                  print(e);
                }
              } else {
                try {
                  usersRef.doc(userProfile.id).update({
                    "bio": bio,
                    "linkSharing": sharingStatus,
                    "facebookLink": facebookLink,
                    "twitterLink": twitterLink,
                    "snapchatLink": snapchatLink,
                    "instagramLink": instagramLink,
                    "pinterestLink": pinterestLink,
                    "twitchLink": twitchLink,
                    "youtubeLink": youtubeLink,
                    "linkedinLink": linkedinLink,
                    "phoneNo": phoneNo,
                    "workplace": workplace,
                    "personalWebsiteLink": personalWebsiteLink,
                    "fullName": fullName,
                    "personalEmail": personalEmail,
                    "workEmail": workEmail,
                    "tiktokLink": tiktokLink,
                    "profileURL":
                        "https://godzeela-flutter.web.app/#/profile/${userProfile.id}",
                  });

                  try {
                    DocumentSnapshot doc =
                        await usersRef.doc(currentUser.uid).get();
                    userProfile = UserProfile.fromDocument(doc);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    isLoading = false;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                } catch (e) {
                  print(e);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Padding buildEditSocialMediaInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SocialItemTile(
              focusNode: fbFocusNode,
              title: "Facebook",
              initialText: facebookLink == null ? "" : facebookLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  facebookLink = null;
                else
                  facebookLink = value;
              },
              onPressEdit: () => fbFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: instaFocusNode,
              title: "Instagram",
              initialText: instagramLink == null ? "" : instagramLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  instagramLink = null;
                else
                  instagramLink = value;
              },
              onPressEdit: () => instaFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: twitterFocusNode,
              title: "Twitter",
              initialText: twitterLink == null ? "" : twitterLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  twitterLink = null;
                else
                  twitterLink = value;
              },
              onPressEdit: () => twitterFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: youtubeFocusNode,
              title: "YouTube",
              initialText: youtubeLink == null ? "" : youtubeLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  youtubeLink = null;
                else
                  youtubeLink = value;
              },
              onPressEdit: () => youtubeFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: pinterestFocusNode,
              title: "Pinterest",
              initialText: pinterestLink == null ? "" : pinterestLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  pinterestLink = null;
                else
                  pinterestLink = value;
              },
              onPressEdit: () => pinterestFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: linkedinFocusNode,
              title: "LinkedIn",
              initialText: linkedinLink == null ? "" : linkedinLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  linkedinLink = null;
                else
                  linkedinLink = value;
              },
              onPressEdit: () => linkedinFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: twitchFocusNode,
              title: "Twitch",
              initialText: twitchLink == null ? "" : twitchLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  twitchLink = null;
                else
                  twitchLink = value;
              },
              onPressEdit: () => twitchFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: snapchatFocusNode,
              title: "Snapchat",
              initialText: snapchatLink == null ? "" : snapchatLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  snapchatLink = null;
                else
                  snapchatLink = value;
              },
              onPressEdit: () => snapchatFocusNode.requestFocus(),
            ),
            SocialItemTile(
              focusNode: tiktokFocus,
              title: "TikTok",
              initialText: snapchatLink == null ? "" : tiktokLink,
              labelText: "Paste Profile Link",
              onEditField: (value) {
                if (value == "")
                  tiktokLink = null;
                else
                  tiktokLink = value;
              },
              onPressEdit: () => tiktokFocus.requestFocus(),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildEditPersonalInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SocialItemTile(
              focusNode: fullNameFocus,
              title: "Full Name",
              iconData: Icons.person_outline,
              initialText: fullName == null ? "" : fullName,
              labelText: "Enter Full Name",
              onEditField: (value) => fullName = value,
              onPressEdit: () => fullNameFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: wPlaceFocus,
              title: "Work Place",
              iconData: Icons.work,
              initialText: workplace == null ? "" : workplace,
              labelText: "Enter Workplace",
              onEditField: (value) => workplace = value,
              onPressEdit: () => wPlaceFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: pEmailFocus,
              title: "Personal Email",
              iconData: Icons.email,
              initialText: personalEmail == null ? "" : personalEmail,
              labelText: "Enter Personal Email",
              onEditField: (value) => personalEmail = value,
              onPressEdit: () => pEmailFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: wEmailFocus,
              title: "Work Email",
              iconData: Icons.email,
              initialText: workEmail == null ? "" : workEmail,
              labelText: "Enter Work Email",
              onEditField: (value) => workEmail = value,
              onPressEdit: () => wEmailFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: phoneFocus,
              title: "Phone Number",
              iconData: Icons.phone,
              initialText: phoneNo == null ? "" : phoneNo,
              labelText: "Enter Phone No.",
              onEditField: (value) => phoneNo = value,
              onPressEdit: () => phoneFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: pWebFocus,
              title: "Personal Website",
              iconData: Icons.link,
              initialText:
                  personalWebsiteLink == null ? "" : personalWebsiteLink,
              labelText: "Enter Website Link",
              onEditField: (value) => personalWebsiteLink = value,
              onPressEdit: () => pWebFocus.requestFocus(),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildEditBusinessInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SocialItemTile(
              focusNode: fullNameFocus,
              title: "Full Business Name",
              iconData: Icons.business,
              initialText: fullName == null ? "" : fullName,
              labelText: "Enter Full Business Name",
              onEditField: (value) => fullName = value,
              onPressEdit: () => fullNameFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: wPlaceFocus,
              title: "Address",
              iconData: Icons.pin_drop,
              initialText: workplace == null ? "" : workplace,
              labelText: "Enter Address",
              onEditField: (value) => workplace = value,
              onPressEdit: () => wPlaceFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: wEmailFocus,
              title: "Business Email",
              iconData: Icons.email,
              initialText: workEmail == null ? "" : workEmail,
              labelText: "Enter Business Email",
              onEditField: (value) => workEmail = value,
              onPressEdit: () => wEmailFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: phoneFocus,
              title: "Phone Number",
              iconData: Icons.phone,
              initialText: phoneNo == null ? "" : phoneNo,
              labelText: "Enter Phone No.",
              onEditField: (value) => phoneNo = value,
              onPressEdit: () => phoneFocus.requestFocus(),
            ),
            SocialItemTile(
              focusNode: pWebFocus,
              title: "Business Website",
              iconData: Icons.link,
              initialText:
                  personalWebsiteLink == null ? "" : personalWebsiteLink,
              labelText: "Enter Website Link",
              onEditField: (value) => personalWebsiteLink = value,
              onPressEdit: () => pWebFocus.requestFocus(),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.av_timer,
                            size: 30.0,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            "Opening Time",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: textFont,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          pickedTime = await showTimePicker(
                            context: context,
                            initialTime: initialTime,
                          );
                          setState(() {
                            openingTime = "${pickedTime.format(context)}";
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      title: Text(openingTime != "" ? openingTime : "Not set!",textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
