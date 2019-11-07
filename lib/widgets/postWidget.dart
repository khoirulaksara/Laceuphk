import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import '../model/Posts.dart';

class PostState extends State<PostWidget>{
  final Posts posts;

  PostState(this.posts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(posts.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Image.network(posts.imageurl),
            IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.green, size: 48.0),
                onPressed: () {
                  Navigator.pop(context);
                }),
            RaisedButton(
                child: Text('PRESS ME'),
                onPressed: () {
                  _showOKScreen(context);
                })
          ]),
        ));
  }

  _showOKScreen(BuildContext context) async {
    bool value = await Navigator.push(context,
        MaterialPageRoute<bool>(builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(children: [
            GestureDetector(
                child: Text('OK'),
                onTap: () {
                  Navigator.pop(context, true);
                }),
            GestureDetector(
                child: Text('NOT OK'),
                onTap: () {
                  Navigator.pop(context, false);
                })
          ]));
    }));
    var alert = AlertDialog(
      content: Text((value != null && value)
          ? "OK was pressed"
          : "NOT OK or BACK was pressed"),
      actions: <Widget>[
        FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
    showDialog(context: context, child: alert);
  }
}

class PostWidget extends StatefulWidget {
final Posts posts;

  PostWidget(this.posts){
    if(posts == null){
      throw ArgumentError(
        "newsPage of PostPage cannot be null. Received: '$posts'");
    }
  }

  @override
  createState() => PostState(posts);
}