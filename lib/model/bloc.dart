import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import '../utils/wp-api.dart';
import '../model/post.dart';

class Bloc {
  var _posts = <Post>[];
  var pageNumber = 1;
  List<int> _ids = [];

  final _postsSubject = BehaviorSubject<UnmodifiableListView<Post>>();
  Stream<List<Post>> get posts => _postsSubject.stream;

  Bloc() {
    _updatePosts().then((_) {
      _postsSubject.add(UnmodifiableListView(_posts));
    });
  }

  previousPage() {
    if (pageNumber > 1) {
      pageNumber--;
      _updatePosts().then((_) {
        _postsSubject.add(UnmodifiableListView(_posts));
      });
    }
  }

  nextPage() {
    pageNumber++;
    _updatePosts().then((_) {
      _postsSubject.add(UnmodifiableListView(_posts));
    });
  }

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
    final listURL =
        WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
    final listResponse = await http.get(listURL);
    final parsedJson = jsonDecode(listResponse.body);
    for (var parsedJson in parsedJson) {
      _ids.add(parsedJson["id"]);
    }
    final futurePosts = _ids.map((id) => _getPost(id));
    final posts = await Future.wait(futurePosts);
    _posts = posts;
  }
}

class ApiError extends Error {
  final String errorMessage;
  ApiError(this.errorMessage);
}
