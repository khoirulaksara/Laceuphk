import 'package:http/http.dart' as http;

class Post {
  final String title;
  //final String content;
  final String imageurl;
  final int postId;

  const Post({this.title, this.imageurl, this.postId});

  factory Post.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;
    return Post(
      title: json['title'],
      imageurl: json["media"]["colormag-featured-image"],
      postId: json["id"],
    );
  }
}