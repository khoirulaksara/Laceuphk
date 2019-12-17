import 'package:flutter/material.dart';
import '../utils/wp-api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:math';

var imageList = [
  "https://whatsticker.online/stickers_asset/ws-pack-36/c1eae0c4c5-1010.png",
  "https://whatsticker.online/stickers_asset/ws-pack-36/f8237bd5bd-103.png",
  "https://whatsticker.online/stickers_asset/ws-pack-36/4307cf4f976-1019.png",
  "https://whatsticker.online/stickers_asset/ws-pack-36/601857f0636-1017.png",
  "https://whatsticker.online/stickers_asset/ws-pack-36/5f43d463b9a-106.png",
  "https://whatsticker.online/stickers_asset/ws-pack-36/760253e6c87-102.png"
];

List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(1, 1),
];

List<Widget> _tiles = <Widget>[
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
  _Example01Tile(),
];

class Explore extends StatelessWidget {
  Explore({Key key}) : super(key: key);
  Widget _appBarTitle = Text(WordpressApi.appTitle);

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("HI"),
          ),
          body: StaggeredGridView.count(
            crossAxisCount: 3,
            staggeredTiles: _staggeredTiles,
            children: _tiles,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            //padding: const EdgeInsets.all(0.0),
          )),
    );
  }
}

class _Example01Tile extends StatelessWidget {
  //const _Example01Tile(this.iconData);

  //final Color backgroundColor;
  //final IconData iconData;
  var ranNum = Random();
  var _controller = YoutubePlayerController(
    initialVideoId: 'vbncFS-HavM',
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
