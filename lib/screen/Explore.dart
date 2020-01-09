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

  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

  List<Widget> _tiles = <Widget>[];

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
    //_loadData();
    return true;
  }

  _loadData() async {
    print("Loading Data 1");
    imageList.clear();
    _staggeredTiles.clear();
    _tiles.clear();

    await WordpressApi.loadURL();
    String dataURL =
        WordpressApi.firstTitleUrl.replaceAll('*', pageNumber.toString());
    http.Response response = await http.get(dataURL);
    final postJSON = jsonDecode(response.body);
    for (var postJSON in postJSON) {
      imageList.add(postJSON["media"]["colormag-featured-image"]);
      print(postJSON["media"]["colormag-featured-image"]);
      Image(image: NetworkImage(postJSON["media"]["colormag-featured-image"]))
          .image
          .resolve(ImageConfiguration())
          .addListener(ImageStreamListener((ImageInfo imageInfo, bool _) {
            int width = imageInfo.image.width;
            int height = imageInfo.image.height;
                 print("The width of the image is: ${width} and the height is: ${height} ");
                 print(width/height);
                 if (width / height > 1.3) {
                   // horizontal
                   _staggeredTiles.add(StaggeredTile.count(2, 1));
                   print("horizontal");
                 } else if (width / height < 0.5) {
                   // vertical
                   _staggeredTiles.add(StaggeredTile.count(1, 2));
                   print("vertical");
                 } 
                 else {
                   // 1:1
                   _staggeredTiles.add(StaggeredTile.count(1, 1));
                   print("1 to 1");
                 }  
          }));
          _tiles.add(_ImageTile());
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
        child: StaggeredGridView.count(
          crossAxisCount: 3,
          staggeredTiles: _staggeredTiles,
          children: _tiles,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: main,
      //drawer: DrawerWidget(),
    );
  }
}

class _VideoTile extends StatelessWidget {
  final _controller = YoutubePlayerController(
    initialVideoId: 'ohBQ59OXnYM',
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
            progressIndicatorColor: Colors.red,
            onReady: () {
              print('Player is ready.');
            },
          )),
    );
  }
}

class _ImageTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {}, child: Image.network(imageList[0])),
    );
  }
}
