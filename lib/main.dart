import 'package:flutter/material.dart';
import './screen/News.dart';
import './screen/Store.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    News(),
    StorePage(),
  ];

  List<Widget> bottomNavIconList = [
    Icon(Icons.home, size: 35),
    Icon(Icons.store, size: 35),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaceupHK',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
          body: _pageOptions[_selectedPage],
          // bottomNavigationBar: Container(
          //   height: 70,
          //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
          //     BoxShadow(
          //         color: Colors.black12.withOpacity(0.065),
          //         offset: Offset(0, -3),
          //         blurRadius: 10)
          //   ]),
          //   child: Row(
          //     children: bottomNavIconList.map((item) {
          //       var index = bottomNavIconList.indexOf(item);
          //       return Expanded(
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               _selectedPage = index;
          //             });
          //           },
          //           child: bottomNavItem(item, index == _selectedPage),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // )
          ),
    );
  }
}

bottomNavItem(Widget item, bool isSelected) => Container(
      decoration: BoxDecoration(
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.black12.withOpacity(.02),
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ]
              : []),
      child: item,
    );
