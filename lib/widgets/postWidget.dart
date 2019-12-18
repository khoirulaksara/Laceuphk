import 'package:flutter/material.dart';
import '../model/Posts.dart';
import '../utils/wp-api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class PostState extends State<PostWidget> {
  final Posts posts;
  String nResult;
  Scaffold main;
  PostState(this.posts);
  List<Image> gallery = new List();

  @override
  void initState() {
    super.initState();
    main = Scaffold(
        backgroundColor: Color(0xFF2d3447),
        body: Center(child: CircularProgressIndicator()));
    _loadContent();
  }

  _loadContent() async {
    var contentLink = WordpressApi.contentURL + posts.postId.toString();
    http.Response response = await http.get(contentLink);
    setState(() {
      final postJSON = jsonDecode(response.body);
      if (postJSON.toString() != "[]") {
        nResult = postJSON["content"];
        main = Scaffold(
            backgroundColor: Color(0xFF2d3447),
            appBar: AppBar(
              title: Text(posts.title),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(children: [
                  Image.network(posts.imageurl),
                  SizedBox(
                    height: 20,
                  ),
                  //Text(textResult, style: TextStyle(color: Colors.white)),
                  Html(
                    onLinkTap: (url) async {
                      print(url);
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Could not launch $url'),
                              );
                            });
                      }
                    },
                    data: nResult,
                    defaultTextStyle: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ));
      } else {
        main = Scaffold(
            backgroundColor: Color(0xFF2d3447),
            appBar: AppBar(
              title: Text(posts.title),
              elevation: 0.0,
            ),
            body: Center(child: Text("No Content")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return main;
  }
}

class PostWidget extends StatefulWidget {
  final Posts posts;

  PostWidget(this.posts) {
    if (posts == null) {
      throw ArgumentError(
          "newsPage of PostPage cannot be null. Received: '$posts'");
    }
  }

  @override
  createState() => PostState(posts);
}
