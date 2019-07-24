import 'package:DW/src/models/Video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player/youtube_player.dart';

class PlayVideo extends StatefulWidget {
  final Video source;
  PlayVideo(this.source);
  PlayVideoState createState() {
    return new PlayVideoState(source);
  }
}

class PlayVideoState extends State<PlayVideo> {
  Video source;
  PlayVideoState(this.source);
  // YoutubePlayerController _controller = YoutubePlayerController();

  // void listener() {
  //   if (_controller.value.playerState == PlayerState.ENDED) {}
  //   setState(() {
  //     _playerStatus = _controller.value.playerState.toString();
  //     _errorCode = _controller.value.errorCode.toString();
  //   });
  // }

  Widget build(context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 5.0, left: 280.0),
            child: Image(
              width: 35.0,
              height: 35.0,
              image: AssetImage("assets/img/dw_logo1.png"),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  YoutubePlayer(
                    context: context,
                    source: source.videoId,
                    quality: YoutubeQuality.HD,
                    // callbackController is (optional).
                    // use it to control player on your own.
                    // callbackController: (controller) {
                    // },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 15, 30),
                    child: Text(
                      source.videoTitle,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 15, 30),
                    child: Text(
                      DateTime.parse(source.uploadDate).toIso8601String(),
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
