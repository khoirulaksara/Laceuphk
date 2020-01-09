import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'post.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import '../utils/wp-api.dart';
import '../model/post.dart';


class Bloc {
  final _postsSubject = BehaviorSubject<UnmodifiableListView<Post>>();

  var _posts = <Post>[];

  List<int> _ids = [
    9922,
    9902,
    9893,
    9889,
    9877,  
  ];

  Bloc() {
    _updatePosts().then((_) {
      _postsSubject.add(UnmodifiableListView(_posts));
    });
  }

  Stream<List<Post>> get posts => _postsSubject.stream;

  Future<Post> _getPost(int id) async {
    final postURL = WordpressApi.contentURL + id.toString();
    final postResponse = await http.get(postURL);
    if (postResponse.statusCode == 200) {
      return Post.fromJson(jsonDecode(postResponse.body));
    }
    throw ApiError("Article $id couldn't be fetched.");
  }

  Future<Null> _updatePosts() async {
    await WordpressApi.loadURL();
    final futurePosts = _ids.map((id) => _getPost(id));
    final posts = await Future.wait(futurePosts);
    _posts = posts;
  }
}

class ApiError extends Error {
  final String errorMessage;
  ApiError(this.errorMessage);
}