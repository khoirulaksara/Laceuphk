import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'wp-api.dart';
import './Postwidget.dart';
import './Posts.dart';

class NewsState extends State<News> {
  var _posts = <Posts>[];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _posts.length ,
          itemBuilder: (BuildContext context, int position) {
            //if (position.isOdd) return Divider();

            final index = position ;

            return _buildRow(index);
          }),
    );
  }

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
        final posts = Posts(
            postJSON['title'],
            postJSON["media"]["thumbnail"]);
        _posts.add(posts);
      }
    });
  }
}

class News extends StatefulWidget {
  @override
  createState() => NewsState();
}
