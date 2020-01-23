import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Explore extends StatelessWidget {
  final _controller = YoutubePlayerController(
      initialVideoId: 'epfPe2U_2Xk',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        forceHideAnnotation: true,
      ));

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
      child: Column(
        children: <Widget>[
          Container(
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
          ),
        ],
      ),
    );
  }
}
