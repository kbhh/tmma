import 'package:DW/src/app.dart';
import 'package:DW/src/widgets/favorites_list.dart';
import 'package:flutter/material.dart';
import 'package:DW/src/pages/home_posts.dart';
import 'package:DW/src/pages/sport_posts.dart';
import 'package:DW/src/localization/localizations.dart';

import 'package:DW/src/pages/business_posts.dart';
import 'package:DW/src/pages/world_posts.dart';
import 'package:DW/src/pages/tech_posts.dart';
import 'package:DW/src/pages/videos/news_videos.dart';

enum Languages { fr, en }

class HomePage extends StatefulWidget {
  final void Function(String) langChange;
  HomePage(this.langChange);

  @override
  HomePageState createState() {
    return new HomePageState(langChange);
  }
}

class HomePageState extends State<HomePage> {
  int selecteIndex = 0;
  List<Widget> bodys = <Widget>[
    new MainContent(),
    new VideosContent(),
    new FavContent(),
  ];
  List<int> numberTabs = [5, 6, 1];

  final void Function(String) langChange;
  HomePageState(this.langChange);

  @override
  Widget build(BuildContext context) {
    List<Widget> homeTabs = <Widget>[
      Tab(text: AppLocalizations.of(context).trans("home")),
      Tab(text: AppLocalizations.of(context).trans("business")),
      Tab(text: AppLocalizations.of(context).trans("sport")),
      Tab(
        text: AppLocalizations.of(context).trans("technology"),
      ),
      Tab(
        text: AppLocalizations.of(context).trans("world"),
      ),
    ];
    List<Widget> videoTabs = <Widget>[
      Tab(text: AppLocalizations.of(context).trans("news")),
      Tab(text: AppLocalizations.of(context).trans("amharicnews")),
      Tab(text: AppLocalizations.of(context).trans("programs")),
      Tab(text: AppLocalizations.of(context).trans("interviews")),
      Tab(text: AppLocalizations.of(context).trans("press_conf")),
      Tab(text: AppLocalizations.of(context).trans("documentry")),
    ];
    List<Widget> favTabs = <Widget>[
      Tab(text: AppLocalizations.of(context).trans("news")),
    ];
    List tabBars = [homeTabs, videoTabs, favTabs];
    var langs = ['fr', 'en'];
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: PopupMenuButton(
              icon: Icon(
                Icons.language,
                size: 40,
              ),
              onSelected: (Languages reslut) {
                setState(() {
                  langChange(langs[reslut.index]);
                });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<Languages>>[
                  const PopupMenuItem<Languages>(
                    value: Languages.fr,
                    child: Text('አማርኛ'),
                  ),
                  const PopupMenuItem<Languages>(
                    value: Languages.en,
                    child: Text('ትግርኛ'),
                  ),
                ];
              },
            ),
          )
        ],
        title: Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Image(
            width: 35.0,
            height: 35.0,
            image: AssetImage("assets/img/dw_logo1.png"),
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          tabs: tabBars[selecteIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff8f0924),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subject,
              color: Colors.white70,
            ),
            title: new Text(
              AppLocalizations.of(context).trans("news"),
              style: TextStyle(color: Colors.white70),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.live_tv,
              color: Colors.white70,
            ),
            title: new Text(
              AppLocalizations.of(context).trans("tv"),
              style: TextStyle(color: Colors.white70),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white70,
            ),
            title: new Text(
              AppLocalizations.of(context).trans("fav"),
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
        currentIndex: selecteIndex,
        onTap: (index) {
          final HomeState state = Home.of(context);
          state.changeNumberOfTabs(numberTabs[index]);
          setState(() {
            selecteIndex = index;
          });
        },
      ),
      body: bodys[selecteIndex],
    );
  }
}

class MainContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        HomePosts(),
        BusinessPosts(),
        SportPosts(),
        TechPosts(),
        WorldPosts()
      ],
    );
  }
}

class FavContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        new FavoritesList(),
      ],
    );
  }
}

class VideosContent extends StatelessWidget {
  Widget build(BuildContext context) {
    var channelId = 'UCv2j8jQyHVi6rTr1HDezP3g';
    return TabBarView(
      children: <Widget>[
        new NewsVideos(channelId, "ዜና|ሰዓት -አማርኛ", 25),
        new NewsVideos(channelId, "አማርኛ|ዜና", 25),
        new NewsVideos(channelId, "ፃንሒት|ዘተ", 25),
        new NewsVideos(channelId, "ሰነዳዊ|ምድላዉ", 25),
        new NewsVideos(channelId, "መልእኽቲ|መግለፂ", 25),
        new NewsVideos(channelId, "ሰነዳዊ|ምድላዉ", 25),
      ],
    );
  }
}
