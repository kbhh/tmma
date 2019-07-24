import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/Post.dart';

class PostSlide extends StatelessWidget {
  Post post;

  PostSlide(this.post);

  Widget build(context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        semanticContainer: true,
        child: Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new CachedNetworkImageProvider(
                    post.postFeaturedMedia != null
                        ? post.postFeaturedMedia.thumbnail
                        : "https://www.dw.uffey.com/wp-content/uploads/2019/07/dw-circleAsset-1Uffey-2.png",
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                post.postTitle,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
