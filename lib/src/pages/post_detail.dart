import 'package:cached_network_image/cached_network_image.dart';
import 'package:DW/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/Post.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  final String lang;
  PostDetail(this.post, this.lang);

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 10,
            valueColor: AlwaysStoppedAnimation(Colors.redAccent)),
      ),
    );

    final postDate = Container(
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        getDate(),
        style: TextStyle(color: Colors.white),
      ),
    );
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40.0),
        Text(
          post.postCatagories.cats[0].toString(),
          style: TextStyle(color: Colors.white, fontSize: 19.0),
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 5.0),
        Text(
          post.postTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 2, child: levelIndicator),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(
              flex: 5,
              child: postDate,
            )
          ],
        ),
      ],
    );

    final topContent = SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.35,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                height: MediaQuery.of(context).size.height * 1.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new CachedNetworkImageProvider(
                      post.postFeaturedMedia != null
                          ? post.postFeaturedMedia.thumbnail
                          : "https://www.dw.uffey.com/wp-content/uploads/2019/07/dw-circleAsset-1Uffey-2.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                )),
            Container(
              height: MediaQuery.of(context).size.height * 1.0,
              padding: EdgeInsets.fromLTRB(43.0, 0.0, 7.0, 0.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
              child: Center(
                child: topContentText,
              ),
            ),
          ],
        ),
      ),
    );

    final bottomContentText = Expanded(
      flex: 0,
      child: SingleChildScrollView(
        child: Html(
          useRichText: true,
          data: post.postContent,
          renderNewlines: true,
          defaultTextStyle: TextStyle(fontSize: 16),
        ),
      ),
    );

    final bottomContent = SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  bottomContentText,
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Copyright ©" + DateTime.now().year.toString() + " DW",
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[topContent, bottomContent]),
    );
  }

  String getDate() {
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
