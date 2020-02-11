import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final menuItem = [
    "Dashboard",
    "Messages",
    "Trade History",
    "Setting"
  ];

  final menuIcons = [
    Icons.account_balance_wallet,
    Icons.message,
    Icons.compare_arrows,
    Icons.build
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text("User Name", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text("San Francisco, CA", style: TextStyle(color: Colors.red)),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                        icon: Icon(menuIcons[index], color: Colors.red),
                        label: Text(menuItem[index],
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {}),
                  );
                },
              ),
            ),
            FlatButton.icon(
                icon: Icon(Icons.do_not_disturb, color: Colors.red),
                label: Text("Logout", style: TextStyle(color: Colors.black)),
                onPressed: () {}),
          ],
        ),
      ),
    ));
  }
}
