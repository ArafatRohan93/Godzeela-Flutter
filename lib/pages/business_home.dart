import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godzeela_flutter/components/chips.dart';
import 'package:godzeela_flutter/components/business_card.dart';
import 'package:godzeela_flutter/components/social_item_tile.dart';
import 'package:godzeela_flutter/models/business_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class BusinessHome extends StatefulWidget {
  final BusinessProfile businessProfile;
  BusinessHome({this.businessProfile});

  @override
  _BusinessHomeState createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
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
        new ClipboardData(text: "${widget.businessProfile.profileURL}"));
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
                padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left:32, right:32),
                child: Container(
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: MediaQuery.of(context).size.width * .7,
                      child: Image(
                        fit: BoxFit.contain,
                        image: businessProfile.photoURL != null
                            ? CachedNetworkImageProvider(
                                businessProfile.photoURL)
                            : AssetImage(
                                "assets/images/dummyProfile.png",
                              ),
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: new Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2.0,
                    ),
                    
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
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
                    "${widget.businessProfile.username}",
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
                  onDoubleTap: () => launchURL(
                      "http://www.godzeela.link/profile.php?id=${businessProfile.id}"),
                  onLongPress: () => copyToClipboard(
                      "http://www.godzeela.link/profile.php?id=${businessProfile.id}"),
                  child: Text("www.godzeela.link/...",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                        fontFamily: textFont,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis),
                ),
              ), 
                   Padding(
                     padding:  EdgeInsets.only(left:32.0,right: 32.0,top:8.0,bottom: 8.0,),
                     child: BusinessCard(
                       businessName: widget.businessProfile.businessName,
                       bio: widget.businessProfile.bio,
                       websiteLink: widget.businessProfile.businessWebsiteLink,
                       phoneNo: widget.businessProfile.phoneNo,
                       openingTime: widget.businessProfile.openingTime
                     ),
                   ),
              Padding(
                padding: EdgeInsets.only(left:20.0,right: 20.0,top:10.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SocialItemGridTile(
                        title: "Facebook",
                        activate:
                            businessProfile.facebookLink == null ? false : true,
                        link: businessProfile.facebookLink,
                      ),
                    ),
                    Expanded(
                      child: SocialItemGridTile(
                        title: "Instagram",
                        activate:
                            businessProfile.instagramLink == null ? false : true,
                        link: businessProfile.instagramLink,
                      ),
                    ),
                    Expanded(
                      child: SocialItemGridTile(
                        title: "Twitter",
                        activate:
                            businessProfile.twitterLink == null ? false : true,
                        link: businessProfile.twitterLink,
                      ),
                    ),
                    // Orientation.portrait == true ? Text(""):SizedBox(width:30.0),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:20.0,right: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SocialItemGridTile(
                        title: "LinkedIn",
                        activate:
                            businessProfile.linkedinLink == null ? false : true,
                        link: businessProfile.linkedinLink,
                      ),
                    ),
                    Expanded(
                      child: SocialItemGridTile(
                        title: "YouTube",
                        activate:
                            businessProfile.youtubeLink == null ? false : true,
                        link: businessProfile.youtubeLink,
                      ),
                    ),
                    Expanded(
                      child: SocialItemGridTile(
                        title: "Twitch",
                        activate:
                            businessProfile.twitchLink == null ? false : true,
                        link: businessProfile.twitchLink,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:20.0,right: 20.0,bottom: 10.0,),
                child: Row(
                  children: [
                    Expanded(
                      child: SocialItemGridTile(
                        title: "Pinterest",
                        activate:
                            businessProfile.pinterestLink == null ? false : true,
                        link: businessProfile.pinterestLink,
                      ),
                    ),
                    Expanded(
                      child: SocialItemGridTile(
                        title: "TikTok",
                        activate:
                            businessProfile.snapchatLink == null ? false : true,
                        link: businessProfile.snapchatLink,
                      ),
                    ),
                    Expanded(
                      child: SocialItemGridTile(
                        title: "Snapchat",
                        activate:
                            businessProfile.snapchatLink == null ? false : true,
                        link: businessProfile.snapchatLink,
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
