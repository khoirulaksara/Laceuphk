import 'package:flutter/material.dart';
import 'package:flutter_laceuphk/widgets/cardScrollWidget.dart';
import 'package:flutter_laceuphk/widgets/postWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/wp-api.dart';
import '../model/Posts.dart';
import '../widgets/customIcons.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var _posts = <Posts>[];
  var reversed_posts;
  var currentPage;
  Container main;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    main = Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Center(child: CircularProgressIndicator()));
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return main;
  }

  _loadData() async {
    const String dataURL = Strings.dataUrl;
    http.Response response = await http.get(dataURL);
    setState(() {
      final postJSON = jsonDecode(response.body);
      for (var postJSON in postJSON) {
        final posts = Posts(
            postJSON['title'], postJSON["media"]["colormag-featured-image"]);
        _posts.add(posts);
        reversed_posts = _posts.reversed.toList();
      }

      _controller = PageController(initialPage: _posts.length - 1);
      currentPage = _posts.length - 1.0;
      _controller.addListener(() {
        setState(() {
          currentPage = _controller.page;
          main = Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  Color(0xFF1b1e44),
                  Color(0xFF2d3447),
                ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    tileMode: TileMode.clamp)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
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
                            "Posts",
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 6),
                                child: Text("Latest",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("10 Stories",
                              style: TextStyle(color: Colors.blueAccent))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PostWidget(
                                reversed_posts[currentPage.round()])));
                      },
                      child: Stack(
                        children: <Widget>[
                          CardScrollWidget(currentPage, _posts),
                          Positioned.fill(
                            child: PageView.builder(
                              itemCount: _posts.length,
                              controller: _controller,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Container();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Editor's Pick",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 46.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                              )),
                          IconButton(
                            icon: Icon(
                              CustomIcons.option,
                              size: 12.0,
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
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                child: Text("Most Viewed",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text("9+ Stories",
                              style: TextStyle(color: Colors.blueAccent))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset("lib/assets/images/image_02.jpg",
                                width: 296.0, height: 222.0),
                          ),
                        )
                      ],
                    )
                  ],
                ))),
          );
        });
      });

      main = Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
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
                        "Posts",
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 6),
                            child: Text("Latest",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("10 Stories",
                          style: TextStyle(color: Colors.blueAccent))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            PostWidget(reversed_posts[currentPage.round()])));
                  },
                  child: Stack(
                    children: <Widget>[
                      CardScrollWidget(currentPage, _posts),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: _posts.length,
                          controller: _controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Editor's Pick",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                          )),
                      IconButton(
                        icon: Icon(
                          CustomIcons.option,
                          size: 12.0,
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
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("Most Viewed",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("9+ Stories",
                          style: TextStyle(color: Colors.blueAccent))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("lib/assets/images/image_02.jpg",
                            width: 296.0, height: 222.0),
                      ),
                    )
                  ],
                )
              ],
            ))),
      );
    });
  }
}
