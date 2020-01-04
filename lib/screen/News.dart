import 'dart:collection';

import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/cardScrollWidget.dart';
import '../widgets/postWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/wp-api.dart';
import '../model/post.dart';
import '../widgets/customIcons.dart';
import 'package:loadmore/loadmore.dart';
import '../model/bloc.dart';

// To implement the drawer in next version
import '../widgets/drawerWidget.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    Bloc myStream = InheritedBloc.of(context).mybloc;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Stack(
        children: <Widget>[
          StreamBuilder<UnmodifiableListView<Post>>(
              stream: myStream.posts,
              initialData: UnmodifiableListView<Post>([]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }
                return ListView(
                  children: snapshot.data.map<Widget>(_buildItem).toList(),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildItem(Post post) {
    return Text(post.title);
  }
}
