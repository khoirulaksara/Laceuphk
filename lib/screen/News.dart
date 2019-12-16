import 'package:flutter/material.dart';
import 'package:flutter_laceuphk/widgets/cardScrollWidget.dart';
import 'package:flutter_laceuphk/widgets/postWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/wp-api.dart';
import '../model/Posts.dart';
import '../widgets/customIcons.dart';
import '../widgets/searchResultWidget.dart';

// To implement the drawer in next version
import '../widgets/drawerWidget.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var _firstCatPosts = <Posts>[];
  var _secondCatPosts = <Posts>[];
  var _searchResultPosts = <Posts>[];
  var reversedPosts;
  var currentPage;
  var pageNumber = 1;
  var searchResultPageNumber = 1;
  bool _isLoading = false;
  Container main;

  PageController _controller;
  List<Widget> reviewPostWidget = List();
  List<Widget> resultList = List();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
    size: 30,
  );
  Widget _appBarTitle = Text(WordpressApi.appTitle);

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
        this._appBarTitle = Text(WordpressApi.appTitle);
      }
    });
  }

  setUI() {
    _isLoading = false;
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
        body: RefreshIndicator(
          onRefresh: () {
            pageNumber = 1;
            return _loadData();
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          WordpressApi.firstTitle,
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
                          onPressed: () {
                            if (_isLoading) {
                              print("Loading, Dont't click");
                            } else {
                              print("Start Load");
                              pageNumber++;
                              _loadData();
                            }
                          },
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
                              child: Text(WordpressApi.firstSubtitle1,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(WordpressApi.firstSubtitle2,
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
                        CardScrollWidget(currentPage, _firstCatPosts),
                        Positioned.fill(
                          child: PageView.builder(
                            itemCount: _firstCatPosts.length,
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
                        Text(WordpressApi.specialTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontFamily: "Calibre-Semibold",
                              letterSpacing: 1.0,
                            )),
                        // No function for iconbutton at this moment, so temp hide here
                        // IconButton(
                        //   icon: Icon(
                        //     CustomIcons.option,
                        //     size: 12.0,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () {
                        //     print("Test 2");
                        //   },
                        // )
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
                              child: Text(WordpressApi.specialSubtitle1,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(WordpressApi.specialSubtitle2,
                            style: TextStyle(color: Colors.blueAccent))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ]),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    delegate: SliverChildListDelegate(reviewPostWidget)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _search(String keyword) async {
    while (resultList.length != 0) {
      resultList.removeLast();
    }
    while (_searchResultPosts.length != 0) {
      _searchResultPosts.removeLast();
    }
    String searchURL = WordpressApi.searchURL
        .replaceAll('keyword', keyword)
        .replaceAll('*', searchResultPageNumber.toString());
    print("The search url is: " + searchURL);
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
          _searchResultPosts.add(post);
          resultList.add(SearchResultWidget(_searchResultPosts[i]));
          i++;
        } else {
          final post = Posts(
              resultJSON['title'],
              "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg",
              resultJSON["id"]);
          _searchResultPosts.add(post);
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
    while (_secondCatPosts.length != 0) {
      _secondCatPosts.removeLast();
    }
    while (reviewPostWidget.length != 0) {
      reviewPostWidget.removeLast();
    }
    print("Loading Data 2");
    String dataURL2 =
        WordpressApi.specialTitleURL.replaceAll('*', WordpressApi.catNumber);
    http.Response response2 = await http.get(dataURL2);
    setState(() {
      final postJSON2 = jsonDecode(response2.body);
      for (var postJSON2 in postJSON2) {
        if (postJSON2["media"].toString() != "false") {
          var imgURL = (postJSON2["media"]["colormag-featured-image"])
              .toString()
              .replaceAll('54.254.148.234', 'laceuphk.com');
          final posts2 = Posts(postJSON2['title'], imgURL, postJSON2["id"]);
          _secondCatPosts.add(posts2);

          reviewPostWidget.add(GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => PostWidget(posts2)));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF1b1e44),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(3.0, 6.0),
                              blurRadius: 10.0)
                        ]),
                    child: Stack(children: <Widget>[
                      Image.network(imgURL, fit: BoxFit.cover),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Text(
                          postJSON2['title'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ])),
              ),
            ),
          ));
        } else {
          final posts2 = Posts(
              postJSON2['title'],
              "https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg",
              postJSON2["id"]);
          _secondCatPosts.add(posts2);
        }
      }
    });
  }

  _loadData() async {
    _isLoading = true;
    print("Loading Data 1");
    while (_firstCatPosts.length != 0) {
      _firstCatPosts.removeLast();
    }
    await WordpressApi.loadURL();
    String dataURL =
        WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
    http.Response response = await http.get(dataURL);
    await _loadData2();
    setState(() {
      this._appBarTitle = Text(WordpressApi.appTitle);
      final postJSON = jsonDecode(response.body);
      for (var postJSON in postJSON) {
        final posts = Posts(postJSON['title'],
            postJSON["media"]["colormag-featured-image"], postJSON["id"]);
        _firstCatPosts.add(posts);
        reversedPosts = _firstCatPosts.reversed.toList();
      }
      setUI();
      _controller = PageController(initialPage: _firstCatPosts.length - 1);
      currentPage = _firstCatPosts.length - 1;
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
