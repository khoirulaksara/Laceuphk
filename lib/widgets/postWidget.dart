import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../model/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget(this.post) {
    if (post == null) {
      throw ArgumentError(
          "newsPage of PostPage cannot be null. Received: '$post'");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: AutoSizeText(post.title, maxLines: 1),
          elevation: 0.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                data: post.content,
                defaultTextStyle: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
