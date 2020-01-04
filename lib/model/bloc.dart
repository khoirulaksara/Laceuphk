import 'dart:async';
import 'dart:convert';
import 'package:flutter_laceuphk/model/post.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import '../utils/wp-api.dart';

class Bloc {
  final _postsSubject = BehaviorSubject<List<Post>>();

  var _posts = <Post>[];

  Bloc() {
    _updatePosts().then((_) {
      _postsSubject.add(_posts);
    });
  }

  Stream<List<Post>> get posts => _postsSubject.stream;

  Future<Post> _getPostbyPage(int pageNumber) async {
    final postURL =
        WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
    final postResponse = await http.get(postURL);
    if (postResponse.statusCode == 200) {
      return Post.fromJson(jsonDecode(postResponse.body));
    }
  }

  Future<Null> _updatePosts() async {
    final futurePosts = _getPostbyPage(1);
    final posts = await Future.wait(futurePosts);
    return posts;
  }
}
