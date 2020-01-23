import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

import '../model/post.dart';
import '../model/bloc.dart';
import '../main.dart';
import '../widgets/postWidget.dart';

class PostSearch extends SearchDelegate<Post> {
  var keyword = "";

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Bloc myBloc = InheritedBloc.of(context).mybloc;
    keyword = query;
    var searchPageNumber = 1;
    List<Post> list = [];

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      if (list.length == 0) {
        myBloc.searchPostByKeyword(keyword, 1).then((data) {
          setState(() {
            list = data;
          });
        });
      }

      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PostWidget(list[index].postId)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 200.0),
                                child: Image.network(list[index].imageurl)),
                            SizedBox(height: 10),
                            Text(list[index].title),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SpringButton(
                SpringButtonType.OnlyScale,
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (searchPageNumber > 1) {
                    searchPageNumber--;
                  }
                  myBloc
                      .searchPostByKeyword(keyword, searchPageNumber)
                      .then((data) {
                    setState(() {
                      list = data;
                    });
                  });
                },
              ),
              SizedBox(width: 20),
              SpringButton(
                SpringButtonType.OnlyScale,
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  searchPageNumber++;
                  myBloc
                      .searchPostByKeyword(keyword, searchPageNumber)
                      .then((data) {
                    setState(() {
                      list = data;
                    });
                  });
                },
              ),
              SizedBox(width: 20)
            ],
          ),
          SizedBox(height: 10)
        ],
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
