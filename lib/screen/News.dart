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
  var _reviewPosts = <Posts>[];
  var reversedPosts;
  var currentPage;
  Container main;
  PageController _controller;
  List<Widget> reviewPostWidget = new List();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("LaceupHK"),
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                CustomIcons.menu,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {},
            );
          },
        ),
        actions: <Widget>[
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
      body: main,
    );
  }

  setUI() {
    print("Setting UI");

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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "News",
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
                          PostWidget(reversedPosts[currentPage.round()])));
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
                    Text("Shoes Review",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviewPostWidget,
              )
            ],
          ))),
    );
  }

  _loadData2() async {
    const String dataURL2 = Strings.shoesReviewURL;
    http.Response response2 = await http.get(dataURL2);
    setState(() {
      final postJSON2 = jsonDecode(response2.body);
      for (var postJSON2 in postJSON2) {
        if (postJSON2["media"].toString() != "false") {
          var imgURL = (postJSON2["media"]["colormag-featured-image"])
              .toString()
              .replaceAll('54.254.148.234', 'laceuphk.com');
          final posts2 = Posts(postJSON2['title'], imgURL, postJSON2["id"]);
          _reviewPosts.add(posts2);

          reviewPostWidget.add(GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => PostWidget(posts2)));
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(imgURL, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ));
          reviewPostWidget.add(Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              postJSON2['title'],
              style: TextStyle(color: Colors.white),
            ),
          ));
          reviewPostWidget.add(SizedBox(
            height: 20.0,
          ));
        } else {
          final posts2 = Posts(
              postJSON2['title'],
              "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg",
              postJSON2["id"]);
          _reviewPosts.add(posts2);
        }
      }
    });
  }

  _loadData() async {
    const String dataURL = Strings.dataUrl;
    http.Response response = await http.get(dataURL);
    await _loadData2();
    setState(() {
      final postJSON = jsonDecode(response.body);
      for (var postJSON in postJSON) {
        final posts = Posts(postJSON['title'],
            postJSON["media"]["colormag-featured-image"], postJSON["id"]);
        _posts.add(posts);
        reversedPosts = _posts.reversed.toList();
      }
      _controller = PageController(initialPage: _posts.length - 1);
      currentPage = _posts.length - 1.0;
      _controller.addListener(() {
        setState(() {
          currentPage = _controller.page;
          setUI();
        });
      });
    });
    setUI();
  }
}
