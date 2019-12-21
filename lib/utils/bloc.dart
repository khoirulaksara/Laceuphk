import 'dart:async';
import '../model/Post.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;

class Bloc {
  final _postsSubject = BehaviorSubject<List<Post>>();

  var _posts = <Post>[];

  Bloc() {

  }

  Stream<List<Post>> get posts => _postsSubject.stream;

  Future<Post> _getPost(int postId) async {
    final postURL = '';
    final postResponse = await http.get(postURL);
    if (postResponse.statusCode == 200) {
      return parsePost(postResponse.body);
    }
  }

  Future<Null> _updateArticles() async {
    final futurePOSTS = 
  }
}