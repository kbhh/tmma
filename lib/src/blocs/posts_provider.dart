import 'package:flutter/material.dart';
import 'posts_bloc.dart';
export 'posts_bloc.dart';

class PostsProvider extends InheritedWidget {
  final PostsBloc bloc;

  PostsProvider({Key key, Widget child})
      : bloc = PostsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static PostsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PostsProvider)
            as PostsProvider)
        .bloc;
  }
}
