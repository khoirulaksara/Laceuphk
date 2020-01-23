import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String content;
  final String imageurl;
  final int postId;

  const Post({
    @required this.title, 
    @required this.imageurl, 
    @required this.postId, 
    this.content
    });

  factory Post.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;

    String image = "";

    if (json["media"] == false) {
      image = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/1280px-No_image_available_600_x_450.svg.png";
    } else {
      image = json["media"]["colormag-featured-image"];
    }

    return Post(
      title: json['title'],
      imageurl: image,
      postId: json["id"],
      content: json["content"],
    );
  }
}