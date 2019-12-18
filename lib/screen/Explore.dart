import 'package:flutter/material.dart';
import '../utils/wp-api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loadmore/loadmore.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

List<String> imageList = [];
int get count => imageList.length;

class _ExploreState extends State<Explore> {
  Widget _appBarTitle = Text(WordpressApi.appTitle);

  int pageNumber = 1;
  Container main;

  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
    StaggeredTile.count(1, 2),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(2, 2),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
    StaggeredTile.count(1, 1),
  ];

  List<Widget> _tiles = <Widget>[
    _VideoTile(),
    _ImageTile(),
    _ImageTile(),
    _ImageTile(),
    _ImageTile(),
    _ImageTile(),
    _VideoTile(),
    _ImageTile(),
    _ImageTile(),
    _ImageTile(),
  ];

  @override
  void initState() {
    super.initState();
    main = Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Center(child: CircularProgressIndicator()));
    _loadData();
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    _loadData();
    return true;
  }

  _loadData() async {
    print("Loading Data 1");
    while (count != 0) {
      imageList.removeLast();
    }
    await WordpressApi.loadURL();
    String dataURL =
        WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
    http.Response response = await http.get(dataURL);
    final postJSON = jsonDecode(response.body);
    for (var postJSON in postJSON) {
      imageList.add(postJSON["media"]["colormag-featured-image"]);
    }
    setUI();
  }

  setUI() {
    print("Setting UI");
    setState(() {
      main = Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: LoadMore(
          isFinish: count >= 5,
          onLoadMore: _loadMore,
          child: StaggeredGridView.count(
            crossAxisCount: 3,
            staggeredTiles: _staggeredTiles,
            children: _tiles,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            //padding: const EdgeInsets.all(0.0),
          ),
          whenEmptyLoad: false,
          delegate: DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.chinese,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        elevation: 0.0,
      ),
      body: main,
      //drawer: DrawerWidget(),
    );
  }
}

class _VideoTile extends StatelessWidget {
  final _controller = YoutubePlayerController(
    initialVideoId: 'L0MK7qz13bU',
    flags: YoutubePlayerFlags(
      mute: false,
      autoPlay: false,
      forceHideAnnotation: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {},
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: false,
            progressIndicatorColor: Colors.amber,
            onReady: () {
              print('Player is ready.');
            },
          )),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final ranNum = Random();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {}, child: Image.network(imageList[ranNum.nextInt(count)])),
    );
  }
}
