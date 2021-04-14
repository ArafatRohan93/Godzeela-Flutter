import 'package:flutter/material.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';
import 'package:godzeela_flutter/pages/view_popup.dart';

class SocialItemTile extends StatelessWidget {
  const SocialItemTile(
      {this.title,
      this.focusNode,
      this.iconData,
      this.labelText,
      this.onEditField,
      this.initialText,
      this.onPressEdit});

  final String title;
  final FocusNode focusNode;
  final IconData iconData;
  final String labelText;
  final Function onEditField;
  final String initialText;
  final Function onPressEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   width: 1.0,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      size: 30.0,
                    ),
                    Text(
                      "$title",
                      style: TextStyle(fontSize: 15.0, fontFamily: textFont),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => this.focusNode.requestFocus(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: TextField(
                  focusNode: focusNode,
                  controller: TextEditingController()..text = '$initialText',
                  onChanged: onEditField,
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: "$labelText"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialItemGridTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool activate;
  final String link;
  SocialItemGridTile({
    this.title,
    this.iconData,
    this.activate,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          
          showModalBottomSheet(
            context: context,
            builder: (context) =>  ViewPopUp(title: title, link: link != null ? link : "No Link available!"),
          );
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  // borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                    color: activate
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: Icon(
                    iconData,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(
                //       iconData,
                //       size: 50,
                //     ),
                //     // Text(title),
                //   ],
                // ),
              ),
            ),
            activate
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                      size: 15.0,
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
