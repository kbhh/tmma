import 'package:DW/src/models/Video.dart';
import 'package:DW/src/pages/videos/play_video.dart';
import 'package:flutter/material.dart';
import 'package:DW/src/localization/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

import 'package:DW/src/pages/post_detail.dart';
import 'package:DW/src/models/Post.dart';
import 'package:DW/src/home.dart';

class HomeInherited extends InheritedWidget {
  HomeInherited({Key key, @required Widget child, @required this.data})
      : super(key: key, child: child);

  final HomeState data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }

  static HomeState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(HomeInherited)
            as HomeInherited)
        .data;
  }
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  String _locale = 'en';
  int _number_tabs = 5;

  @override
  bool get wantKeepAlive => true;

  changeNumberOfTabs(int tabs) {
    setState(() {
      _number_tabs = tabs;
    });
  }

  void onChangeLanguage(String lang) {
    setState(() {
      _locale = lang;
    });
  }

  String get lang => _locale;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xff8f0924),
        accentColor: const Color(0xff8f0924),
      ),
      locale: Locale(_locale),
      supportedLocales: [const Locale('fr', 'FR'), const Locale('en', 'US')],
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      onGenerateRoute: routes,
      home: DefaultTabController(
        length: _number_tabs,
        child: new HomeInherited(
          data: this,
          child: new HomePage(
            onChangeLanguage,
          ),
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/postDetail") {
      Post post;

      if (settings.arguments != null) {
        post = settings.arguments;
      }
      return MaterialPageRoute(
        builder: (context) {
          return PostDetail(post, _locale);
        },
      );
    } else if (settings.name == "/play") {
      Video source;
      if (settings.arguments != null) {
        source = settings.arguments;
      }
      return MaterialPageRoute(builder: (context) {
        return PlayVideo(source);
      });
    }
  }
}
