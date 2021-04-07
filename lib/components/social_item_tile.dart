import 'package:flutter/material.dart';
import 'package:godzeela_flutter/constants.dart';
import 'package:godzeela_flutter/pages/home.dart';

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
