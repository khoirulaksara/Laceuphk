import 'package:flutter/material.dart';
import '../model/Posts.dart';
import '../utils/wp-api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart';

class PostState extends State<PostWidget> {
  final Posts posts;
  var result;
  Scaffold main;
  PostState(this.posts);

  @override
  void initState(){
    super.initState();
    main = Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Center(child: CircularProgressIndicator())
    );
    _loadContent();
  }

  _loadContent() async {
    var contentLink = Strings.contentURL + posts.postId.toString();
    http.Response response = await http.get(contentLink);
    setState(() {
      final postJSON = jsonDecode(response.body);
      result = parse(postJSON["content"]);
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
              Text(
                result.documentElement.text.toString(),
                style: TextStyle(color: Colors.white)
                )
            ]),
          ),
        ));
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
