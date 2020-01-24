import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final menuItem = [
    "Dashboard",
    "Messages",
    "Utility Bills",
    "Funds Transfer",
    "Branches"
  ];

  final menuIcons = [
    Icons.account_balance_wallet,
    Icons.message,
    Icons.compare,
    Icons.compare_arrows,
    Icons.build
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color(0xFF343441),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text("Roger Hoffman", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text("San Francisco, CA", style: TextStyle(color: Colors.grey)),
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
                        icon: Icon(menuIcons[index], color: Colors.white),
                        label: Text(menuItem[index],
                            style: TextStyle(color: Colors.grey)),
                        onPressed: () {}),
                  );
                },
              ),
            ),
            FlatButton.icon(
                icon: Icon(Icons.do_not_disturb, color: Colors.white),
                label: Text("Logout", style: TextStyle(color: Colors.grey)),
                onPressed: () {}),
          ],
        ),
      ),
    ));
  }
}
