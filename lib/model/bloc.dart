import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import '../utils/wp-api.dart';
import '../model/post.dart';

class Bloc {
  var _posts = <Post>[];
  var _cat2Post = <Post>[];
  var pageNumber = 1;

  final _postsSubject = BehaviorSubject<UnmodifiableListView<Post>>();
  final _cat2Subject = BehaviorSubject<UnmodifiableListView<Post>>();
  final _isLoadingSubject = BehaviorSubject<bool>();

  Stream<List<Post>> get posts => _postsSubject.stream;
  Stream<List<Post>> get cat2posts => _cat2Subject.stream;
  Stream<bool> get isLoading => _isLoadingSubject.stream;

  Bloc() {
    _isLoadingSubject.add(true);
    _updatePosts().then((_) {
      _postsSubject.add(UnmodifiableListView(_posts));
      _isLoadingSubject.add(false);
    }).then((_) {
      _getCat2Post().then((_) {
        _cat2Subject.add(UnmodifiableListView(_cat2Post));
      });
    });
  }

  previousPage() {
    if (pageNumber > 1) {
      pageNumber--;
      _isLoadingSubject.add(true);
      _updatePosts().then((_) {
        _postsSubject.add(UnmodifiableListView(_posts));
        _isLoadingSubject.add(false);
      });
    }
  }

  nextPage() {
    pageNumber++;
    _isLoadingSubject.add(true);
    _updatePosts().then((_) {
      _postsSubject.add(UnmodifiableListView(_posts));
      _isLoadingSubject.add(false);
    });
  }

  Future<Null> _getCat2Post() async {
    final cat2URL = WordpressApi.specialTitleURL.replaceAll('*', WordpressApi.catNumber);
    final response = await http.get(cat2URL);
    final parsedJson = jsonDecode(response.body);
    for (var parsedJson in parsedJson) {
      _cat2Post.add(Post.fromJson(parsedJson));
    }
  }

  Future<List<Post>> searchPostByKeyword(String keyword, int pageNumber) async {
    List<Post> resultList = List<Post>();
    var searchPageNumber = pageNumber;
    final searchURL = WordpressApi.searchURL
        .replaceAll('keyword', keyword)
        .replaceAll('*', searchPageNumber.toString());
    final searchResponse = await http.get(searchURL);
    final resultJson = jsonDecode(searchResponse.body);
    if (searchResponse.statusCode == 200) {
      for (var resultJson in resultJson) {
        resultList.add(Post.fromJson(resultJson));
      }
      return resultList;
    } else {
      throw ApiError("Article with $keyword couldn't be fetched.");
    }
  }

  Future<Post> getPostById(int id) async {
    final postURL = WordpressApi.contentURL + id.toString();
    final postResponse = await http.get(postURL);
    if (postResponse.statusCode == 200) {
      return Post.fromJson(jsonDecode(postResponse.body));
    } else {
      throw ApiError("Article $id couldn't be fetched.");
    }
  }

  Future<Null> _updatePosts() async {
    await WordpressApi.loadURL();
    final listURL =
        WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
    final listResponse = await http.get(listURL);
    final parsedJson = jsonDecode(listResponse.body);
    for (var parsedJson in parsedJson) {
      _posts.add(Post.fromJson(parsedJson));
    }
  }
}

class ApiError extends Error {
  final String errorMessage;
  ApiError(this.errorMessage);
}
