import 'package:flutter/material.dart';
import 'package:flutter_laceuphk/widgets/cardScrollWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/wp-api.dart';
import '../widgets/Postwidget.dart';
import '../model/Posts.dart';
import '../widgets/customIcons.dart';


class NewsState extends State<News> {
  var _posts = <Posts>[];

  @override
  void initState() {
    super.initState();
    
    _loadData();
    currentPage = _posts.length - 1;
  }

  var currentPage;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: _posts.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = _posts.length - 1;
        currentPage = controller.page;
      });
    });

    return Scaffold(
        backgroundColor: Color(0xFF2d3447),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 30, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      CustomIcons.menu,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Trending",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1),
                  ),
                  IconButton(
                    icon: Icon(
                      CustomIcons.option,
                      size: 12,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFdd6e6e),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                        child: Text("Animated",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("25+ Stories",
                      style: TextStyle(color: Colors.blueAccent))
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage, _posts),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: _posts.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            )
          ],
        )));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: ListView.builder(
  //         itemCount: _posts.length ,
  //         itemBuilder: (BuildContext context, int position) {
  //           //if (position.isOdd) return Divider();
  //           final index = position ;
  //           return _buildRow(index);
  //         }),
  //   );
  // }

  Widget _buildRow(int i) {
    return GestureDetector(
      onTap: () {
        _pushPost(_posts[i]);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.network(_posts[i].imageurl),
            ),
            Expanded(
              flex: 6,
              child: Text("${_posts[i].title}"),
            ),
          ]),
        ),
      ),
    );
  }

  _pushPost(Posts posts) {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: true,
            //transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, _, __) {
              return PostWidget(posts);
            }
            // transitionsBuilder:
            //     (_, Animation<double> animation, __, Widget child) {
            //   return FadeTransition(
            //     opacity: animation,
            //     child: RotationTransition(
            //       turns: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            //       child: child,
            //     ),
            //   );
            ));
  }

  _loadData() async {
    const String dataURL = Strings.dataUrl;
    http.Response response = await http.get(dataURL);
    setState(() {
      final postJSON = jsonDecode(response.body);
      for (var postJSON in postJSON) {
        final posts = Posts(postJSON['title'], postJSON["media"]["thumbnail"]);
        _posts.add(posts);
      }   
    });
  }
}

class News extends StatefulWidget {
  @override
  createState() => NewsState();
}
