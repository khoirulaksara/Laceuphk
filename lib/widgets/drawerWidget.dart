import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("object");
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("LaceupHK"),
            decoration: BoxDecoration(
              color: Color(0xFF2d3447)
            ),
          )
        ],
      ),
    );
  }
}