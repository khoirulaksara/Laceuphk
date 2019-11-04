import 'package:flutter/material.dart';
import 'wp-api.dart';
import 'package:html/parser.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder(
        future: fetchWpPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Map wppost = snapshot.data[index];
                var imageurl = wppost["_embedded"]["wp:featuredmedia"][0]
                    ["media_details"]["sizes"]["thumbnail"]["source_url"];
                return GestureDetector(
                  onTap: () {
                    print("Container was tapped");
                  },
                  child: buildCard(imageurl, wppost),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }

  Card buildCard(imageurl, Map wppost) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Text(
                wppost['title']['rendered'],
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
