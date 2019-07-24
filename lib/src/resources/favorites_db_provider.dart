import 'dart:convert';

import 'package:DW/src/models/Post.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

final root = "https://www.dw.uffey.com/wp-json/wp/v2";

class FavDbProvider {
  Database db;
  Client client = Client();

  FavDbProvider();
  init() async {
    Directory documentDirectoryy = await getApplicationDocumentsDirectory();
    final path = join(documentDirectoryy.path, 'dw_db565.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
           CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            postId INTEGER UNIQUE
           )
         """);
      },
    );
  }

  Future<List<Post>> fetchPostOf() async {
    try {
      await init();
      List<dynamic> favs = await fetchPosts();
      List<int> favsList =
          favs.map((fav) => fav['postId']).toList().cast<int>();
      String includes = favsList.join(',');
      final response = await client.get("$root/posts?include=$includes&_embed");

      List<dynamic> iterablePosts = json.decode(response.body);

      List<Post> posts =
          iterablePosts.map((model) => Post.fromJson(model)).toList();

      return posts;
    } catch (error) {
      print(error);
      return List();
    }
  }

  Future<List> getPosts() {}

  Future<List> fetchPosts() async {
    final postMaps = await db.query("favorites");

    return postMaps;
  }

  addPost(int post) async {
    try {
      db.insert("favorites", {'postId': post});
    } catch (err) {
      throw (err);
    }
  }
}
