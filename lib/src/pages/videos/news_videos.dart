import 'package:DW/src/app.dart';
import 'package:DW/src/widgets/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:DW/src/blocs/videos_provider.dart';

class NewsVideos extends StatelessWidget {
  final String id;
  final String query;
  final int maxResult;

  NewsVideos(this.id, this.query, this.maxResult);
  @override
  Widget build(BuildContext context) {
    return VideosProvider(
      child: VideoList(id, query, maxResult),
    );
  }
}

class VideoList extends StatelessWidget {
  final String id;
  final String query;
  final int maxResult;

  VideoList(this.id, this.query, this.maxResult);

  @override
  Widget build(BuildContext context) {
    final bloc = VideosProvider.of(context);
    bloc.fetchVideos(id, query, maxResult);
    final HomeState state = Home.of(context);
    var lang = state.lang;
    var noData;
    var networkError;

    if (lang == "en") {
      noData = "ዳታ የብሉን";
      networkError =
          "ምንም  ዓይነት ዳታ ክንረክብ አይከ አልናን ብይዝኦም ኢንተርኔቶም ቼክ ጌሮም ደጊሞም ይሞክሩ";
    } else {
      noData = "ዳታ የለዉም";
      networkError =
          "ምንም  ዓይነት ዳታ  ማግኘት አልቻልንም እባክዎ ኢንተርኔትዎን ቼክ አድርገዉ ደግመዉ ይሞክሩ";
    }

    return Container(
      child: StreamBuilder(
        stream: bloc.videos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    size: 50,
                  ),
                  Text(
                    networkError,
                    textAlign: TextAlign.center,
                  ),
                  FlatButton(
                    child: Text(
                      "ይሞክሩ",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      bloc.fetchVideos(id, query, maxResult);
                    },
                  )
                ],
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: VideoTile(snapshot.data[index]),
                    onTap: () {
                      Navigator.pushNamed(context, '/play',
                          arguments: snapshot.data[index]);
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    Text(noData),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
