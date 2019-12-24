import 'dart:async';
import 'dart:convert';
import 'package:flutter_laceuphk/model/post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import '../utils/wp-api.dart';

class Bloc {
  final _postsSubject = BehaviorSubject<List<Post>>();

  var _posts = <Post>[];

  List<int> _ids = [
    11088,
    11181,
    11175,
    11160,
    11151,  
  ];

  Bloc() {
    _updatePosts().then((_) {
      _postsSubject.add(_posts);
    });
  }

  Stream<List<Post>> get posts => _postsSubject.stream;

  Future<Post> _getPost(int id) async {
    
    final postURL = WordpressApi.contentURL + id.toString();
    final postResponse = await http.get(postURL);
    if (postResponse.statusCode == 200) {
      return Post.fromJson(jsonDecode(postResponse.body));
    }
  }

  Future<Null> _updatePosts() async {
    await WordpressApi.loadURL();
    final futurePosts = _ids.map((id) => _getPost(id));
    final posts = await Future.wait(futurePosts);
    _posts = posts;
  }
}
