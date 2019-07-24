import 'package:cached_network_image/cached_network_image.dart';
import 'package:DW/src/models/Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(this.video);

  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 0.9,
                  child: CachedNetworkImage(
                    imageUrl: video.videoThumbnail,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
              child: Text(
                video.videoTitle,
                style: TextStyle(fontSize: 18, fontFamily: "Gregorian"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
