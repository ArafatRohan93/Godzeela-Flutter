
import 'package:cloud_firestore/cloud_firestore.dart';


class BusinessProfile{

  final String email;
  final String username;
  final String photoURL;
  final String id;
  final String profileURL;
  final String displayName;
  final bool linkSharing;
  final String bio;
  final String facebookLink;
  final String twitterLink;
  final String twitchLink;
  final String instagramLink;
  final String pinterestLink;
  final String snapchatLink;
  final String tiktokLink;
  final String youtubeLink;
  final String linkedinLink;
  final String phoneNo;
  final String address;
  final String businessWebsiteLink;
  final String businessName;
  final String businessEmail;
  final String openingTime;
  final String accountType;


  BusinessProfile( {this.accountType,this.businessEmail,this.openingTime,this.businessName,this.businessWebsiteLink,this.facebookLink, this.twitterLink, this.twitchLink, this.instagramLink, this.pinterestLink, this.snapchatLink, this.youtubeLink, this.linkedinLink, this.phoneNo, this.address,this.linkSharing, this.bio,this.id,this.photoURL,this.username, this.profileURL, this.email, this.displayName, this.tiktokLink});

  factory BusinessProfile.fromDocument(DocumentSnapshot doc){
    return BusinessProfile(
      email: doc.data()["email"],
      id: doc.data()["id"],
      username: doc.data()["username"],
      accountType: doc.data()["accountType"],
      businessName: doc.data()["businessName"],
      businessEmail: doc.data()["businessEmail"],
      phoneNo: doc.data()["phoneNo"],
      address: doc.data()["address"],
      businessWebsiteLink: doc.data()["businessWebsiteLink"],
      openingTime: doc.data()["openingTime"],
      profileURL: doc.data()["profileURL"],
      displayName: doc.data()["displayName"],
      photoURL : doc.data()["photoURL"],
      linkSharing : doc.data()["linkSharing"],
      bio: doc.data()["bio"],
      facebookLink: doc.data()["facebookLink"],
      snapchatLink: doc.data()["snapchatLink"],
      instagramLink: doc.data()["instagramLink"],
      linkedinLink: doc.data()["linkedinLink"],
      twitchLink: doc.data()["twitchLink"],
      pinterestLink: doc.data()["pinterestLink"],
      twitterLink: doc.data()["twitterLink"],
      youtubeLink: doc.data()["youtubeLink"],
      tiktokLink: doc.data()["tiktokLink"]
    );
}
}