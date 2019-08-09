import 'package:TMMA/src/app.dart';
import 'package:TMMA/src/widgets/favorites_list.dart';
import 'package:flutter/material.dart';
import 'package:TMMA/src/pages/home_posts.dart';
import 'package:TMMA/src/pages/sport_posts.dart';
import 'package:TMMA/src/localization/localizations.dart';

import 'package:TMMA/src/pages/business_posts.dart';
import 'package:TMMA/src/pages/world_posts.dart';
import 'package:TMMA/src/pages/tech_posts.dart';
import 'package:TMMA/src/pages/videos/news_videos.dart';

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
    HomePosts(),
    new VideosContent(),
    new FavContent(),
  ];
  List<int> numberTabs = [7, 6, 1];

  final void Function(String) langChange;
  HomePageState(this.langChange);

  @override
  Widget build(BuildContext context) {
    List<Widget> navDrawers = <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: const Color(0xff4168b5),
        ),
        child: Container(
          color: const Color(0xff4168b5),
          height: MediaQuery.of(context).size.height * 0.25,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 200.0,
            child: Image(
              image: AssetImage("assets/img/tmma_circle.png"),
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 50.0, top: 30),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context).trans("home"),
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/business');
              },
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context).trans("business"),
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  selecteIndex = 1;
                });
              },
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.directions_run,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context).trans("sport"),
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  selecteIndex = 2;
                });
              },
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.memory,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context).trans("technology"),
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  selecteIndex = 3;
                });
              },
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context).trans("world"),
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              onTap: () {
                setState(() {
                  selecteIndex = 4;
                });
              },
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.business,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                "ኢትዮጵያ",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.location_city,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                "ትግራይ",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
            ListTile(
              leading: Icon(
                Icons.wc,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context).trans("health"),
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Divider(
              height: 5.0,
              color: Colors.black38,
            ),
          ],
        ),
      )
    ];

    var langs = ['fr', 'en'];
    return new Scaffold(
      drawer: Drawer(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(0),
            child: ListView(
              children: navDrawers,
            ),
          ),
        ),
      ),
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
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              "ኤመሓት",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff4168b5),
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
      children: <Widget>[],
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
    var channelId = 'UCW0FmkMO7KkYdIiNKXpY9Ng';
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
