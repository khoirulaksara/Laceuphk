import 'dart:collection';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

import '../main.dart';
import '../widgets/cardScrollWidget.dart';
import '../widgets/postWidget.dart';
import '../model/post.dart';
import '../model/bloc.dart';

// To implement the drawer in next version
// import 'package:loadmore/loadmore.dart';

final imagesLength = 5;

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var currentPage = imagesLength - 1.0;

  @override
  Widget build(BuildContext context) {
    Bloc myBloc = InheritedBloc.of(context).mybloc;

    PageController controller = PageController(initialPage: imagesLength - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Colors.yellow,
            Colors.orange,
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    child: StreamBuilder(
                      stream: myBloc.isLoading,
                      initialData: false,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data) return CircularProgressIndicator();
                        return Container();
                      },
                    ), //CircularProgressIndicator()
                  ),
                  Spacer(),
                  StreamBuilder(
                    stream: myBloc.isLoading,
                    initialData: false,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.data) {
                        return SpringButton(
                          SpringButtonType.OnlyScale,
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            myBloc.previousPage();
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StreamBuilder(
                    stream: myBloc.isLoading,
                    initialData: false,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.data) {
                        return SpringButton(
                          SpringButtonType.OnlyScale,
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            myBloc.nextPage();
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 6.0),
                        child: Text("Animated",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("5 Stories",
                      style: TextStyle(fontSize: 15, color: Colors.blueAccent))
                ],
              ),
            ),
            StreamBuilder<UnmodifiableListView<Post>>(
                stream: myBloc.posts,
                initialData: UnmodifiableListView<Post>([]),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return GestureDetector(
                    onTap: () {
                      Iterable reverser = snapshot.data.reversed;
                      List<Post> reversedPostList = reverser.toList();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PostWidget(
                              reversedPostList[currentPage.round()].postId)));
                    },
                    child: Stack(children: <Widget>[
                      CardScrollWidget(currentPage, snapshot.data),
                      Positioned.fill(
                        child: PageView.builder(
                          onPageChanged: (int page) {
                            var swipingRight = page > controller.page;
                            print(swipingRight);
                          },
                          itemCount: imagesLength,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ]),
                  );
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Favourite",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      )),
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
                        child: Text("Latest",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("9+ Stories",
                      style: TextStyle(fontSize: 15, color: Colors.blueAccent))
                ],
              ),
            ),
          ])),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: StreamBuilder(
              stream: myBloc.cat2posts,
              initialData: UnmodifiableListView<Post>([]),
              builder: (context, snapshot) => SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    PostWidget(snapshot.data[index].postId)));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF1b1e44),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(3.0, 6.0),
                                        blurRadius: 10.0)
                                  ]),
                              child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Image.network(snapshot.data[index].imageurl,
                                        fit: BoxFit.cover),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          snapshot.data[index].title,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ])),
                        ),
                      ),
                    );
                  }, childCount: snapshot.data.length)),
            ),
          ),
        ],
      ),
    );
  }
}
