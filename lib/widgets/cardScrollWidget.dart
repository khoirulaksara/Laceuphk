import 'package:flutter/material.dart';
import 'dart:math';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  var _posts;

  CardScrollWidget(this.currentPage, this._posts);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;
          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();
          var postContoll = _posts.length - 1;

          for (var i = 0; i < _posts.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: GestureDetector(
                  onTap: (){print("object");},
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0)
                    ]),
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){print("object");},
                            child: Image.network(_posts[postContoll].imageurl,
                                fit: BoxFit.cover),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 0,
                                        maxWidth: 250.0,
                                        minHeight: 0,
                                        maxHeight: 100.0,
                                      ),
                                      child: Text(_posts[postContoll].title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontFamily: "SF-Pro-Text-Regular")),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, bottom: 12.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Read More",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
            postContoll--;
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
