import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:godzeela_flutter/components/social_icons.dart';
import 'package:godzeela_flutter/components/social_item_tile.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:flutter_switch/flutter_switch.dart';

class UserHome extends StatefulWidget {
  final UserProfile userProfile;
  UserHome({this.userProfile});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool sharingStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            // shrinkWrap: true,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: CircleAvatar(
                    radius: 90.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: userProfile.photoURL != null
                        ? CachedNetworkImageProvider(userProfile.photoURL)
                        : AssetImage('assets/images/dummy.png'),
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
                        spreadRadius: 5,
                        blurRadius: 7,
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
                    fontSize: 40.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PassionOne',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: FlutterSwitch(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: widget.userProfile.linkSharing,
                                      onToggle: (value) {
                                        setState(() {
                                          sharingStatus = value;
                                          print(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'godzeela.com/${widget.userProfile.username}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'PassionOne',
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    // shrinkWrap: true,
                    crossAxisCount: 3,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      SocialItemGridTile(
                        iconData: SocialIcons.facebook,
                        title: "Facebook",
                        activate: userProfile.facebookLink == null ? false : true,
                        link: userProfile.facebookLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.instagram,
                        title: "Instagram",
                        activate: userProfile.instagramLink == null ? false : true,
                        link: userProfile.instagramLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.twitter,
                        title: "Twitter",
                        activate: userProfile.twitterLink == null ? false : true,
                        link: userProfile.twitterLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.linkedin,
                        title: "LinkedIn",
                        activate: userProfile.linkedinLink == null ? false : true,
                        link: userProfile.linkedinLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.youtube,
                        title: "You Tube",
                        activate: userProfile.youtubeLink == null ? false : true,
                        link: userProfile.youtubeLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.github,
                        title: "GitHub",
                        activate: userProfile.githubLink == null ? false : true,
                        link: userProfile.githubLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.pinterest,
                        title: "Pinterest",
                        activate: userProfile.pinterestLink == null ? false : true,
                        link: userProfile.pinterestLink,
                      ),
                      SocialItemGridTile(
                        iconData: SocialIcons.medium,
                        title: "Medium",
                        activate: userProfile.mediumLink == null ? false : true,
                        link: userProfile.mediumLink,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
