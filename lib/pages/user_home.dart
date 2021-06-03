import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godzeela_flutter/components/chips.dart';
import 'package:godzeela_flutter/components/social_icons.dart';
import 'package:godzeela_flutter/components/social_item_tile.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/edit_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class UserHome extends StatefulWidget {
  final UserProfile userProfile;
  UserHome({this.userProfile});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool sharingStatus = true;

  launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  copyToClipboard(String data) {
    Clipboard.setData(
        new ClipboardData(text: "${widget.userProfile.profileURL}"));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text("Copied to Clipboard"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: CircleAvatar(
                    radius: 90.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: userProfile.photoURL != null
                        ? CachedNetworkImageProvider(userProfile.photoURL)
                        : AssetImage(
                            "assets/images/dummyProfile.png",
                          ),
                  ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 6.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "${widget.userProfile.username}",
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: textFont,
                  ),
                ),
              ),
              Chips(
                  icon: Icon(Icons.link_rounded),
                  widget: GestureDetector(
                  onDoubleTap: () =>
                launchURL("https://godzeela-flutter.web.app/#/profile/${userProfile.id}"),
                  onLongPress: () =>
                copyToClipboard("https://godzeela-flutter.web.app/#/profile/${userProfile.id}"),
                  child: Text(
                  "godzeela.../${widget.userProfile.id}",
                  style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                fontFamily: textFont,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis
                ),
                ),
                ),
                widget.userProfile.fullName == '' || widget.userProfile.fullName == null
                   ? Text(
                 "",
                    )
                   :Chips(
                   icon: Icon(Icons.person),
                   widget:  Text(
                 "${widget.userProfile.fullName}",
                 style: TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
              fontWeight: FontWeight.w300,
              fontFamily: textFont,
                 ),
                    ),
                 ),
                   widget.userProfile.phoneNo == '' || widget.userProfile.phoneNo == null
                    ? Text(
                   "",
                 )
                    : Chips(
                 icon: Icon(Icons.phone_android_rounded),
                 widget:    Text(
                   "${widget.userProfile.phoneNo}",
                   style: TextStyle(
                     fontSize: 15.0,
                     color: Colors.black54,
                     fontWeight: FontWeight.w300,
                     fontFamily: textFont,
                   ),
                 ),
                    ),
                widget.userProfile.personalEmail == '' || widget.userProfile.personalEmail == null
                    ? Text(
                        "",
                      ):Chips(
                  icon: Icon(Icons.email_rounded),
                  widget:Text(
                        "${widget.userProfile.personalEmail}",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                          fontFamily: textFont,
                        ),
                      ),
                ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SocialItemGridTile(
                      title: "Facebook",
                      activate: userProfile.facebookLink == null ? false : true,
                      link: userProfile.facebookLink,
                    ),
                  ),
                  Expanded(
                    child: SocialItemGridTile(
                      title: "Instagram",
                      activate:
                          userProfile.instagramLink == null ? false : true,
                      link: userProfile.instagramLink,
                    ),
                  ),
                  Expanded(
                    child: SocialItemGridTile(
                      title: "Twitter",
                      activate: userProfile.twitterLink == null ? false : true,
                      link: userProfile.twitterLink,
                    ),
                  ),
                  // Orientation.portrait == true ? Text(""):SizedBox(width:30.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SocialItemGridTile(
                      title: "LinkedIn",
                      activate: userProfile.linkedinLink == null ? false : true,
                      link: userProfile.linkedinLink,
                    ),
                  ),
                  Expanded(
                    child: SocialItemGridTile(
                      title: "YouTube",
                      activate: userProfile.youtubeLink == null ? false : true,
                      link: userProfile.youtubeLink,
                    ),
                  ),
                  Expanded(
                    child: SocialItemGridTile(
                      title: "Twitch",
                      activate: userProfile.twitchLink == null ? false : true,
                      link: userProfile.twitchLink,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SocialItemGridTile(
                      title: "Pinterest",
                      activate:
                          userProfile.pinterestLink == null ? false : true,
                      link: userProfile.pinterestLink,
                    ),
                  ),
                  Expanded(
                    child: SocialItemGridTile(
                      title: "TikTok",
                      activate: userProfile.snapchatLink == null ? false : true,
                      link: userProfile.snapchatLink,
                    ),
                  ),
                  Expanded(
                    child: SocialItemGridTile(
                      title: "Snapchat",
                      activate: userProfile.snapchatLink == null ? false : true,
                      link: userProfile.snapchatLink,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
