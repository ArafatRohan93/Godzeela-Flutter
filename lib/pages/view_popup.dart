import 'package:flutter/material.dart';
import 'package:godzeela_flutter/pages/edit_profile.dart';
import 'package:godzeela_flutter/pages/home.dart';

class ViewPopUp extends StatefulWidget {
  ViewPopUp({this.title, this.link});
  final String title;
  final String link;

  @override
  _ViewPopUpState createState() => _ViewPopUpState();
}

class _ViewPopUpState extends State<ViewPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    "${widget.title}",
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
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.link,
                            style: TextStyle(
                                color: Colors.black,
                                // fontFamily: 'PassionOne',
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
                  padding: EdgeInsets.all(2.0),
                  child: RaisedButton(
                    color: Colors.black87,
                    // shape: ShapeBorder(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),),),
                    onPressed: () {
                       Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfile()),
                      ).then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(),));
                });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
            "Edit",
            style: TextStyle(color: Colors.white,
            fontFamily: textFont,
            fontWeight: FontWeight.w300,
            fontSize: 20,
                      ),
                    ),
                    ),
                ),
                ),
              ],),
          ),
        ),
      ),
    );
  }
}
