import 'package:DW/src/app.dart';
import 'package:DW/src/resources/favorites_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:DW/src/widgets/post_tile.dart';
import 'package:DW/src/blocs/posts_provider.dart';

class PostList extends StatefulWidget {
  final List<int> categories;
  PostList(this.categories);

  PostListState createState() {
    return new PostListState(categories);
  }
}

class PostListState extends State<PostList> {
  List<int> categories;
  PostListState(this.categories);

  List<int> favsList;
  FavDbProvider db;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Widget build(context) {
    final bloc = PostsProvider.of(context);
    bloc.fetchPosts(categories, 50);
    initFavs();
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

    return Expanded(
      child: SizedBox(
        child: StreamBuilder(
          stream: bloc.posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text(noData),
                );
              } else {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: PostTile(snapshot.data[index], favsList, db),
                          onTap: () {
                            Navigator.pushNamed(context, '/postDetail',
                                arguments: snapshot.data[index]);
                          },
                        );
                      }),
                  onRefresh: () async {
                    await bloc.fetchPosts(categories, 50);
                  },
                );
              }
            } else if (snapshot.hasError) {
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
                        bloc.fetchPosts(categories, 50);
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  initFavs() async {
    db = FavDbProvider();
    await db.init();
    List<dynamic> favs = await db.fetchPosts();
    favsList = favs.map((fav) => fav['postId']).toList().cast<int>();
  }
}
