import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laceuphk/widgets/cardScrollWidget.dart';
import 'package:flutter_laceuphk/widgets/postWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/wp-api.dart';
import '../model/Posts.dart';
import '../widgets/customIcons.dart';
import '../widgets/searchResultWidget.dart';
import '../widgets/drawerWidget.dart';
import '../utils/wp-api.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var _posts = <Posts>[];
  var _reviewPosts = <Posts>[];
  var _searchPosts = <Posts>[];
  var reversedPosts;
  var currentPage;
  Container main;
  PageController _controller;
  List<Widget> reviewPostWidget = List();
  List<Widget> resultList = List();
  final dio = new Dio();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
    size: 30,
  );
  Widget _appBarTitle = Text("LaceupHK");

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
        title: _appBarTitle,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          )
        ],
      ),
      body: main,
      //drawer: DrawerWidget(),
    );
  }

  _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: Icon(Icons.search)),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onSubmitted: (value) {
              setState(() {
                main = Container(
                    color: Color(0xFF2d3447),
                    child: Center(child: CircularProgressIndicator()));
              });
              _search(value);
            });
      } else {
        setUI();
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text("LaceupHK");
      }
    });
  }

  setUI() {
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
                          fontSize: 35,
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
                          fontSize: 35.0,
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

  _search(String keyword) async {
    while (resultList.length != 0) {
      resultList.removeLast();
    }
    while (_searchPosts.length != 0) {
      _searchPosts.removeLast();
    }
    print(Strings.searchURL + keyword + "&content=false");
    String searchURL = Strings.searchURL + keyword + "&content=false&page=1&per_page=100";
    http.Response response = await http.get(searchURL);
    final resultJSON = jsonDecode(response.body);
    if (resultJSON.toString() == "[]") {
      print("No Search Result");
      resultList.add(Center(
        child: Text("No result"),
      ));
    } else {
      int i = 0;
      for (var resultJSON in resultJSON) {
        if (resultJSON["media"].toString() != "false") {
          var imgURL = (resultJSON["media"]["colormag-featured-image"])
              .toString()
              .replaceAll('54.254.148.234', 'laceuphk.com');
          final post = Posts(resultJSON['title'], imgURL, resultJSON["id"]);
          _searchPosts.add(post);
          resultList.add(SearchResultWidget(_searchPosts[i]));
          i++;
        } else {
          final post = Posts(
              resultJSON['title'],
              "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg",
              resultJSON["id"]);
          _searchPosts.add(post);
        }
      }
    }
    setState(() {
      main = Container(
          color: Color(0xFF2d3447),
          child: ListView(
            children: resultList,
          ));
    });
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
    await Strings.loadURL();
    String dataURL = Strings.dataUrl;
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
