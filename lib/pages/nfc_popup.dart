import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';

class NFCPopUp extends StatefulWidget {
  final String title;
  final String details;

  const NFCPopUp({Key key, this.title, this.details}) : super(key: key);
  @override
  _NFCPopUpState createState() => _NFCPopUpState();
}

class _NFCPopUpState extends State<NFCPopUp> {
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
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontFamily: textFont,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/images/${widget.title.toLowerCase()}.svg",
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "${widget.details}",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontFamily: textFont,
                  ),
                ),
              ),
              
            ]),
          ),
        ),
      ),
    );
  }
}
