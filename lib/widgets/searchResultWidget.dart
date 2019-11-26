import 'package:flutter/material.dart';
import '../model/Posts.dart';
import '../widgets/postWidget.dart';

class SearchResultWidget extends StatelessWidget {
  final Posts post;

  SearchResultWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => PostWidget(post)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(post.imageurl),
                Text(post.title)
              ]),
        ),
      ),
    );
  }
}
