import 'package:flutter/material.dart';
import './screen/News.dart';
//import './screen/Store.dart';
import './screen/Explore.dart';
import './model/bloc.dart';

void main() {
  runApp(InheritedBloc(child: MyApp()));
}

class InheritedBloc extends InheritedWidget {
  final Widget child;
  final mybloc = Bloc();

  InheritedBloc({this.child}) : super(child: child);

  get myBloc => mybloc;

  @override
  bool updateShouldNotify(InheritedBloc oldwidget) => true;

  static InheritedBloc of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();
}

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
    //StorePage(),
    Explore(),
  ];

  List<Widget> bottomNavIconList = [
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    //Icon(Icons.store, size: 35),
    Icon(
      Icons.explore,
      size: 30,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaceupHK',
      theme: ThemeData(
        primaryColor: Color(0xFF2d3447),
      ),
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              title: Text("LaceupHK"),
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
          ),
          //backgroundColor: Color(0xFF1b1e44),
          body: _pageOptions[_selectedPage],
          bottomNavigationBar: Container(
            color: Color(0xFF1b1e44),
            child: SafeArea(
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Color(0xFF1b1e44), boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.065),
                      offset: Offset(0, -3),
                      blurRadius: 10)
                ]),
                child: Row(
                  children: bottomNavIconList.map((item) {
                    var index = bottomNavIconList.indexOf(item);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPage = index;
                          });
                        },
                        child: bottomNavItem(item, index == _selectedPage),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )),
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
