import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godzeela_flutter/components/chips.dart';
import 'package:godzeela_flutter/components/profile_card.dart';
import 'package:godzeela_flutter/components/social_item_tile.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
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
        await launch(url, forceWebView: false);
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
                      width: 2.0,
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
                child: FittedBox(
                                  child: Text(
                    "${widget.userProfile.username}",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontFamily: textFont,
                    ),
                  ),
                ),
              ),
              Chips(
                  icon: Icon(Icons.link_rounded),
                  widget: GestureDetector(
                  onDoubleTap: () =>
                launchURL("http://www.godzeela.link/profile.php?id=${userProfile.id}"),
                  onLongPress: () =>
                copyToClipboard("http://www.godzeela.link/profile.php?id=${userProfile.id}"),
                  child: Text(
                  "www.godzeela.link/...",
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
                 Padding(
                     padding:  EdgeInsets.only(left:32.0,right: 32.0,top:8.0,bottom: 8.0,),
                     child: ProfileCard(
                       bio: widget.userProfile.bio,
                       fullName: widget.userProfile.fullName,
                       phoneNo: widget.userProfile.phoneNo,
                       email: widget.userProfile.personalEmail,
                     ),
                   ),
              
              Padding(
                padding:  EdgeInsets.only(top: 10.0, left:20.0, right: 20.0),
                child: Row(
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
              ),
              Padding(
                padding:  EdgeInsets.only(left:20.0,right: 20.0),
                child: Row(
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
              ),
              Padding(
                padding:  EdgeInsets.only(left:20.0, right: 20.0,bottom: 10.0, ),
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
