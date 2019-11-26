import 'package:flutter/material.dart';
import '../model/Posts.dart';

class SearchResultWidget extends StatelessWidget {
  Posts post;

  SearchResultWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2d3447),
      child: Text(post.title),
    );
  }
}