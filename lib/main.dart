import 'package:flutter/material.dart';
import './News.dart';
import './Store.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaceupHK',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('LaceupHK'),
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('News')),
            BottomNavigationBarItem(
                icon: Icon(Icons.store), title: Text('Store')),
          ],
        ),
      ),
    );
  }
}
