import 'package:flutter/material.dart';
import 'package:TMMA/src/blocs/posts_provider.dart';
import 'package:TMMA/src/widgets/post_list.dart';
import 'package:TMMA/src/widgets/post_slides.dart';
import "package:TMMA/src/app.dart";

class HomePosts extends StatelessWidget {
  Widget build(BuildContext context) {
    final HomeState state = Home.of(context);
    var cats;
    if (state.lang == "fr") {
      cats = [141, 107, 143, 106];
    } else if (state.lang == "en") {
      cats = [125, 123, 121, 158];
    }

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(
          child: Container(
            child: Flex(
              children: <Widget>[
                PostsProvider(child: PostList(cats)),
              ],
              direction: Axis.vertical,
            ),
          ),
        );
      },
    );
  }
}
