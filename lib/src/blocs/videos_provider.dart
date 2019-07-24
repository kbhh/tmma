import 'package:flutter/material.dart';
import 'videos_bloc.dart';
export 'videos_bloc.dart';

class VideosProvider extends InheritedWidget {
  final VideosBloc bloc;

  VideosProvider({Key key, Widget child})
      : bloc = VideosBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static VideosBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(VideosProvider)
            as VideosProvider)
        .bloc;
  }
}
