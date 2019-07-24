import 'package:DW/src/app.dart';
import 'package:flutter/material.dart';
import 'package:DW/src/widgets/post_slide.dart';
import 'package:DW/src/blocs/posts_provider.dart';
import 'package:DW/src/widgets/slides_loading.dart';

class PostSlides extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Widget build(context) {
    final bloc = PostsProvider.of(context);
    final HomeState state = Home.of(context);
    var cats;
    if (state.lang == "fr") {
      cats = [71];
    } else if (state.lang == "en") {
      cats = [160];
    }

    bloc.fetchPosts(cats, 5);
    return Expanded(
      flex: 0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.height * 0.75,
        child: StreamBuilder(
          stream: bloc.posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  await bloc.fetchPosts(cats, 5);
                },
                key: _refreshIndicatorKey,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: new PostSlide(snapshot.data[index]),
                          onTap: () {
                            Navigator.pushNamed(context, '/postDetail',
                                arguments: snapshot.data[index]);
                          });
                    }),
              );
            } else {
              return Center(child: SlidesLoading());
            }
          },
        ),
      ),
    );
  }
}
