import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:godzeela_flutter/components/social_icons.dart';
import 'package:godzeela_flutter/components/social_item_tile.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String bio = userProfile.bio;
  bool sharingStatus;
  FocusNode bioFocusNode,
      fbFocusNode,
      instaFocusNode,
      twitterFocusNode,
      linkedinFocusNode,
      pinterestFocusNode,
      youtubeFocusNode,
      mediumFocusNode,
      githubFocusNode,
      phoneFocus,
      pWebFocus,
      fullNameFocus,
      pEmailFocus,
      wEmailFocus,
      wPlaceFocus;
  bool isLoading = false;
  String facebookLink = userProfile.facebookLink;
  String twitterLink = userProfile.twitterLink;
  String mediumLink = userProfile.mediumLink;
  String instagramLink = userProfile.instagramLink;
  String pinterestLink = userProfile.pinterestLink;
  String githubLink = userProfile.githubLink;
  String youtubeLink = userProfile.youtubeLink;
  String linkedinLink = userProfile.linkedinLink;
  String phoneNo = userProfile.phoneNo;
  String workplace = userProfile.workplace;
  String personalWebsiteLink = userProfile.personalWebsiteLink;
  String fullName = userProfile.fullName;
  String personalEmail = userProfile.personalEmail;
  String workEmail = userProfile.workEmail;

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
    mediumFocusNode = FocusNode();
    githubFocusNode = FocusNode();
    phoneFocus = FocusNode();
    pWebFocus = FocusNode();
    fullNameFocus = FocusNode();
    pEmailFocus = FocusNode();
    wEmailFocus = FocusNode();
    wPlaceFocus = FocusNode();
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
    mediumFocusNode.dispose();
    githubFocusNode.dispose();
    phoneFocus.dispose();
    pWebFocus.dispose();
    fullNameFocus.dispose();
    pEmailFocus.dispose();
    wEmailFocus.dispose();
    wPlaceFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.black54,
                          width: 6.0,
                        ),
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 90.0,
                              backgroundColor: Theme.of(context).primaryColor,
                              backgroundImage: currentUser.photoURL != null
                                  ? CachedNetworkImageProvider(
                                      currentUser.photoURL)
                                  : AssetImage('assets/images/dummy.png'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
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
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: IconButton(
                                  onPressed: () {},
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Text(
                        "Bio",
                        style: TextStyle(fontSize: 25.0, fontFamily: textFont),
                      ),
                      title: TextField(
                        focusNode: bioFocusNode,
                        controller: TextEditingController()
                          ..text = '${userProfile.bio}',
                        onChanged: (value) => bio = value,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Edit Bio"),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                          size: 30.0,
                        ),
                        onPressed: () => bioFocusNode.requestFocus(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sharing",
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: textFont),
                              ),
                              Text(
                                "Allow others to see you online.",
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: CustomSwitch(
                              activeColor: Theme.of(context).primaryColor,
                              value: userProfile.linkSharing,
                              onChanged: (value) {
                                sharingStatus = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Personal Info",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: textFont,
                      ),
                    ),
                  ),
                  SocialItemTile(
                    focusNode: fullNameFocus,
                    title: "Full Name",
                    iconData: Icons.person_outline,
                    initialText: fullName == null
                        ? ""
                        : fullName,
                    labelText: "Enter Full Name",
                    onEditField: (value) => fullName = value,
                    onPressEdit: () => fullNameFocus.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: wPlaceFocus,
                    title: "Work Place",
                    iconData: Icons.work,
                    initialText: workplace == null
                        ? ""
                        : workplace,
                    labelText: "Enter Workplace",
                    onEditField: (value) => workplace = value,
                    onPressEdit: () => wPlaceFocus.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: pEmailFocus,
                    title: "Personal Email",
                    iconData: Icons.email,
                    initialText: personalEmail == null
                        ? ""
                        : personalEmail,
                    labelText: "Enter Personal Email",
                    onEditField: (value) => personalEmail = value,
                    onPressEdit: () => pEmailFocus.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: wEmailFocus,
                    title: "Work Email",
                    iconData: Icons.email,
                    initialText: workEmail == null
                        ? ""
                        : workEmail,
                    labelText: "Enter Work Email",
                    onEditField: (value) => workEmail = value,
                    onPressEdit: () => wEmailFocus.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: phoneFocus,
                    title: "Phone Number",
                    iconData: Icons.phone,
                    initialText:
                        phoneNo == null ? "" : phoneNo,
                    labelText: "Enter Phone No.",
                    onEditField: (value) => phoneNo = value,
                    onPressEdit: () => phoneFocus.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: pWebFocus,
                    title: "Personal Website",
                    iconData: Icons.link,
                    initialText: personalWebsiteLink == null
                        ? ""
                        : personalWebsiteLink,
                    labelText: "Enter Website Link",
                    onEditField: (value) => personalWebsiteLink = value,
                    // onPressEdit: () => pWebFocus.requestFocus(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Add Social Media",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: textFont,
                      ),
                    ),
                  ),
                  SocialItemTile(
                    focusNode: fbFocusNode,
                    title: "Facebook",
                    iconData: SocialIcons.facebook,
                    initialText: facebookLink == null
                        ? ""
                        : facebookLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => fbFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: instaFocusNode,
                    title: "Instagram",
                    iconData: SocialIcons.instagram,
                    initialText: instagramLink == null
                        ? ""
                        : instagramLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => instaFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: twitterFocusNode,
                    title: "Twitter",
                    iconData: SocialIcons.twitter,
                    initialText: twitterLink == null
                        ? ""
                        : twitterLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => twitterFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: youtubeFocusNode,
                    title: "You Tube",
                    iconData: SocialIcons.youtube,
                    initialText: youtubeLink == null
                        ? ""
                        : youtubeLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => youtubeFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: pinterestFocusNode,
                    title: "Pinterest",
                    iconData: SocialIcons.pinterest,
                    initialText: pinterestLink == null
                        ? ""
                        : pinterestLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => pinterestFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: linkedinFocusNode,
                    title: "LinkedIn",
                    iconData: SocialIcons.linkedin,
                    initialText: linkedinLink == null
                        ? ""
                        : linkedinLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => linkedinFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: githubFocusNode,
                    title: "GitHub",
                    iconData: SocialIcons.github,
                    initialText: githubLink == null
                        ? ""
                        : githubLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => githubFocusNode.requestFocus(),
                  ),
                  SocialItemTile(
                    focusNode: mediumFocusNode,
                    title: "Medium",
                    iconData: SocialIcons.medium,
                    initialText: mediumLink == null
                        ? ""
                        : mediumLink,
                    labelText: "Paste Profile Link",
                    onEditField: (value) {},
                    onPressEdit: () => mediumFocusNode.requestFocus(),
                  ),
                  SizedBox(
                    height: 150.0,
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          color: Colors.black87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      usersRef.doc(userProfile.id).update({
                        "linkSharing": sharingStatus,
                        "facebookLink": facebookLink,
                        "twitterLink": twitterLink,
                        "mediumLink": mediumLink,
                        "instagramLink": instagramLink,
                        "pinterestLink": pinterestLink,
                        "githubLink": githubLink,
                        "youtubeLink": youtubeLink,
                        "linkedinLink": linkedinLink,
                        "phoneNo": phoneNo,
                        "workplace": workplace,
                        "personalWebsiteLink": personalWebsiteLink,
                        "fullName": fullName,
                        "personalEmail": personalEmail,
                        "workEmail": workEmail,
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
                        Navigator.pop(context, 1);
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Save Profile",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: textFont,
                          color: Colors.white),
                    ),
                  ),
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
