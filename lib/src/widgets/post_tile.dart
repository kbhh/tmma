import 'package:DW/src/app.dart';
import 'package:DW/src/resources/favorites_db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Post.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostTile extends StatefulWidget {
  Post post;
  List<int> favs;
  FavDbProvider db;

  PostTile(this.post, this.favs, this.db);
  PostTileState createState() {
    return new PostTileState(post, favs, db);
  }
}

class PostTileState extends State<PostTile> {
  Post post;
  List<int> favs;
  FavDbProvider db;

  PostTileState(this.post, this.favs, this.db);

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: SizedBox(
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.7,
                child: Center(
                  child: new CachedNetworkImage(
                    imageUrl: post.postFeaturedMedia != null
                        ? post.postFeaturedMedia.thumbnail
                        : "https://www.dw.uffey.com/wp-content/uploads/2019/07/dw-circleAsset-1Uffey-2.png",
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 2.0, 5.0),
                  child: postDesc(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget postDesc(context) {
    final HomeState state = Home.of(context);
    var lang = state.lang;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.postTitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        ),
        Expanded(
          flex: 0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getDate(lang),
                style: const TextStyle(fontSize: 9.0, color: Colors.black54),
              ),
              Text(
                post.postCatagories.cats[0],
                style: const TextStyle(fontSize: 9.0, color: Colors.black87),
              ),
              GestureDetector(
                child: inFav(post.postId)
                    ? Icon(
                        Icons.bookmark,
                        size: 25.0,
                        color: const Color(0xff8f0924),
                      )
                    : Icon(
                        Icons.bookmark_border,
                        size: 25.0,
                      ),
                onTap: () {
                  if (!inFav(post.postId)) {
                    try {
                      db.addPost(post.postId);
                      setState(() {
                        favs.add(post.postId);
                      });
                    } catch (err) {}
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  bool inFav(int id) {
    if (favs != null) {
      return favs.contains(id) ? true : false;
    }
    return false;
  }

  String getDate(String lang) {
    var parsed_date = DateTime.parse(post.postDate);
    var hours_from_now = DateTime.now().difference(parsed_date).inHours;
    hours_from_now =
        hours_from_now.isNegative ? hours_from_now * -1 : hours_from_now;
    var post_date;

    if (hours_from_now > 24) {
      if (lang == 'en') {
        post_date = parsed_date.difference(DateTime.now()).inDays.isNegative
            ? ("ቅድሚ " +
                (parsed_date.difference(DateTime.now()).inDays * -1)
                    .toString() +
                " መዓልቲ")
            : parsed_date.difference(DateTime.now()).inDays.toString() +
                " መዓልቲ";
      } else {
        post_date = parsed_date.difference(DateTime.now()).inDays.isNegative
            ? ("ከ " +
                (parsed_date.difference(DateTime.now()).inDays * -1)
                    .toString() +
                " ቀን በፊት")
            : "ከ " +
                parsed_date.difference(DateTime.now()).inDays.toString() +
                " ቀን በፊት";
      }
    } else {
      if (lang == 'fr') {
        post_date = "ቅድሚ " + hours_from_now.toString() + "ሰዓት";
      } else {
        post_date = "ከ " + hours_from_now.toString() + "ሰዓት በፊት";
      }
    }

    return post_date;
  }
}
