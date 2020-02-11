import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../model/bloc.dart';
import '../main.dart';

class PostWidget extends StatelessWidget {
  final int id;

  PostWidget(this.id) {
    if (id == null) {
      throw ArgumentError(
          "newsPage of PostPage cannot be null. Received: '$id'");
    }
  }

  @override
  Widget build(BuildContext context) {
    Bloc myBloc = InheritedBloc.of(context).mybloc;

    return FutureBuilder(
      future: myBloc.getPostById(this.id),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.orange,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: AppBar(
                title: AutoSizeText(snapshot.data.title, maxLines: 1),
                elevation: 0.0,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Html(
                      onLinkTap: (url) async {
                        print(url);
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Could not launch $url'),
                                );
                              });
                        }
                      },
                      data: snapshot.data.content,
                      defaultTextStyle: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
              backgroundColor: Colors.orange,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: AppBar(
                  title: AutoSizeText("Loading", maxLines: 1),
                  elevation: 0.0,
                ),
              ),
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
