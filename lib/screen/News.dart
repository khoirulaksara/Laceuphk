import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

import '../main.dart';
import '../widgets/cardScrollWidget.dart';
import '../widgets/postWidget.dart';
import '../model/post.dart';
import '../widgets/customIcons.dart';
import '../model/bloc.dart';
import 'package:spring_button/spring_button.dart';

// To implement the drawer in next version
import '../widgets/drawerWidget.dart';

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
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Trending",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      )),
                  Spacer(),
                  SpringButton(
                    SpringButtonType.OnlyScale,
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                      ),
                      //color: Colors.white,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      myBloc.previousPage();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SpringButton(
                    SpringButtonType.OnlyScale,
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                      ),
                      child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.0,
                          color: Colors.black,
                        ),
                    ),
                    onTap: () {
                      myBloc.nextPage();
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
                  if (!snapshot.hasData) {
                    print("Loading Data");
                    return CircularProgressIndicator();
                  }
                  return GestureDetector(
                    onTap: () {
                      Iterable reverser = snapshot.data.reversed;
                      UnmodifiableListView<Post> reversedPostList =
                          reverser.toList();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PostWidget(
                              reversedPostList[currentPage.round()])));
                    },
                    child: Stack(children: <Widget>[
                      CardScrollWidget(currentPage, snapshot.data),
                      Positioned.fill(
                        child: PageView.builder(
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
            SizedBox(
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
