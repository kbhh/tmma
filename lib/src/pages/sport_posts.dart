import 'package:TMMA/src/app.dart';
import 'package:flutter/material.dart';
// import 'package:TMMA_app/src/resources/news_api_provider.dart';
import 'package:TMMA/src/widgets/post_list.dart';
// import 'package:TMMA/src/providers/posts_provider.dart';
import 'package:TMMA/src/blocs/posts_provider.dart';

class SportPosts extends StatelessWidget {
  Widget build(context) {
    final HomeState state = Home.of(context);
    var cats;
    if (state.lang == "fr") {
      cats = [105];
    } else if (state.lang == "en") {
      cats = [131];
    }

    return Flex(
      children: <Widget>[PostsProvider(child: PostList(cats))],
      direction: Axis.vertical,
    );
  }
}
