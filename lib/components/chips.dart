import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final Icon icon;
  final Widget widget;
  const Chips({this.icon, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: FittedBox(
                      child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: widget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
