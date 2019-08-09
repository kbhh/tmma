import 'package:TMMA/src/app.dart';
import 'package:flutter/material.dart';
// import 'package:TMMA_app/src/resources/news_api_provider.dart';
import 'package:TMMA/src/widgets/post_list.dart';
// import 'package:TMMA_app/src/providers/posts_provider.dart';
import 'package:TMMA/src/blocs/posts_provider.dart';

class BusinessPosts extends StatelessWidget {
  Widget build(context) {
    final HomeState state = Home.of(context);
    var cats;
    if (state.lang == "fr") {
      cats = [104];
    } else if (state.lang == "en") {
      cats = [137];
    }

    return PostsProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Busienss"),
        ),
        body: Center(
          child: Flex(
            children: <Widget>[PostList(cats)],
            direction: Axis.vertical,
          ),
        ),
      ),
    );
  }
}
