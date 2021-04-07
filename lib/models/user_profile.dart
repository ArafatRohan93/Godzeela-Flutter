
import 'package:cloud_firestore/cloud_firestore.dart';


class UserProfile{

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
  final String mediumLink;
  final String instagramLink;
  final String pinterestLink;
  final String githubLink;
  final String youtubeLink;
  final String linkedinLink;
  final String phoneNo;
  final String workplace;
  final String personalWebsiteLink;
  final String fullName;
  final String personalEmail;
  final String workEmail;


  UserProfile({this.personalEmail,this.workEmail,this.fullName,this.personalWebsiteLink,this.facebookLink, this.twitterLink, this.mediumLink, this.instagramLink, this.pinterestLink, this.githubLink, this.youtubeLink, this.linkedinLink, this.phoneNo, this.workplace,this.linkSharing, this.bio,this.id,this.photoURL,this.username, this.profileURL, this.email, this.displayName});

  factory UserProfile.fromDocument(DocumentSnapshot doc){
    return UserProfile(
      email: doc.data()["email"],
      id: doc.data()["id"],
      username: doc.data()["username"],
      profileURL: doc.data()["profileURL"],
      displayName: doc.data()["displayName"],
      photoURL : doc.data()["photoURL"],
      linkSharing : doc.data()["linkSharing"],
      bio: doc.data()["bio"],
      facebookLink: doc.data()["facebookLink"],
      githubLink: doc.data()["githubLink"],
      instagramLink: doc.data()["instagramLink"],
      linkedinLink: doc.data()["linkedinLink"],
      mediumLink: doc.data()["mediumLink"],
      phoneNo: doc.data()["phoneNo"],
      pinterestLink: doc.data()["pinterestLink"],
      twitterLink: doc.data()["twitterLink"],
      workplace: doc.data()["workplace"],
      youtubeLink: doc.data()["youtubeLink"],
      personalWebsiteLink: doc.data()["personalWebsiteLink"],
      fullName: doc.data()["fullName"],
      personalEmail: doc.data()["personalEmail"],
      workEmail: doc.data()["workEmail"]
    );
  }
}