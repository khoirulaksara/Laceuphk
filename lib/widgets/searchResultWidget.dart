import 'package:flutter/material.dart';
import '../model/Post.dart';
import '../widgets/postWidget.dart';

class SearchResultWidget extends StatelessWidget {
  final Post post;

  SearchResultWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => PostWidget(post)));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            decoration: BoxDecoration(color: Color(0xFF1b1e44), boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(3.0, 6.0),
                  blurRadius: 10.0)
            ]),
            child: Stack(
              children: <Widget>[
              Image.network(post.imageurl),
              Positioned(
                left: 8,
                bottom: 8,
                child: Text(
                  post.title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
