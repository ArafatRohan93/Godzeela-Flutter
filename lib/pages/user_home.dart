import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:godzeela_flutter/components/social_icons.dart';
import 'package:godzeela_flutter/models/user_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';


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
      body:  SafeArea(
          child: Center(
            child: Column(
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
              backgroundImage: currentUser.photoURL!= null ?  CachedNetworkImageProvider(currentUser.photoURL) : AssetImage('assets/images/dummy.png'),
            ),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: Colors.black54,
                width: 6.0,
              ),
            ),
          ),
        ),
       Padding(
            padding: EdgeInsets.all(2.0),
            child:  Text(
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
                    child: Row(
                      children:[ 
                        Padding(
                      padding: EdgeInsets.all(0.0),
                      child: CustomSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: widget.userProfile.linkSharing,
                      onChanged: (value) {
                        setState(() {
                          sharingStatus = value;
                        });
                      },
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'godzeela.com/${widget.userProfile.username}',
                        style: TextStyle(color: Colors.black,fontFamily: 'PassionOne',fontSize: 20),
                      ),
                    ),
                      ],
                    ),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
                  
        Expanded(
          child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 4,
              // Generate 100 widgets that display their index in the List.
              children: [
                IconButton(
                  icon: Icon(
                    SocialIcons.facebook,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.twitter,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.linkedin,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.youtube,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.github,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.pinterest,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.medium,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    SocialIcons.instagram,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {},
                ),
              ],),
        ),
      ],
            ),
          ),
        ),
    );
  }
}